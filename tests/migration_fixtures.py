"""Discover the real overlay releases used by migration integration tests."""

from functools import cmp_to_key
from pathlib import Path
import re

from portage.dep import Atom
from portage.versions import vercmp

OVERLAY = Path(__file__).resolve().parents[1]


def variable(text, name):
    match = re.search(r'^' + name + r'\+?="([^"]*)"', text, re.M)
    if match is None:
        raise AssertionError(f'Missing {name} in overlay ebuild')
    return match.group(1)


def version(ebuild):
    return ebuild.stem[len(ebuild.parent.name) + 1:]


def releases(atom, root=OVERLAY):
    paths = [path for path in (root / atom).glob('*.ebuild')
             if version(path).split('-r')[0] != '9999']
    return sorted(paths, key=cmp_to_key(lambda a, b: vercmp(version(a), version(b))))


def transition_pair(original, sonic, *, oldest=False, root=OVERLAY):
    owners = releases(sonic, root)
    if not owners:
        raise AssertionError(f'No release provider for {sonic}')
    owner = owners[0] if oldest else owners[-1]
    posts = [Atom(token.replace('${PV}', version(owner)))
             for value in re.findall(r'^PDEPEND\+?="([^"]*)"', owner.read_text(), re.M)
             for token in value.split()]
    posts = [atom for atom in posts if atom.cp == original]
    if len(posts) != 1 or not posts[0].version:
        raise AssertionError(f'{owner}: expected one versioned post-dependency on {original}')
    stub = root / original / (original.split('/')[-1] + '-' + posts[0].version + '.ebuild')
    if not stub.is_file():
        raise AssertionError(f'{owner}: compatibility ebuild is missing: {stub}')
    return owner, stub


def slots(owner, stub):
    original_slot = variable(stub.read_text(), 'SLOT').removesuffix('-sonicde')
    match = re.search(r'^SLOT="([^"]*)"', owner.read_text(), re.M)
    # Frameworks source slots are inherited from their versioned eclass.
    source_slot = match.group(1) if match else original_slot
    return source_slot, original_slot
