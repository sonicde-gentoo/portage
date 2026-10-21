# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11..14} )
LLVM_COMPAT=( {18..22} )
inherit cmake llvm-r2 python-single-r1

DESCRIPTION="SonicDE Python bindings for Qt 6"
HOMEPAGE="https://github.com/Sonic-DE/sonic-pyside"
SRC_URI="https://github.com/Sonic-DE/sonic-pyside/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/sonic-pyside-${PV}"

LICENSE="|| ( GPL-2 GPL-3 LGPL-3 )"
SLOT="6"
KEYWORDS="~amd64 ~arm64 ~loong ~ppc64 ~riscv ~x86"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"
RESTRICT="test"

# Build the base and QML bindings explicitly instead of enabling whichever
# optional Qt modules happen to be installed on the build host.
RDEPEND="${PYTHON_DEPS}
	!dev-python/pyside:6
	=dev-qt/qtbase-$(ver_cut 1-3)*:6=[dbus,gui,network,widgets]
	=dev-qt/qtdeclarative-$(ver_cut 1-3)*:6=
	$(llvm_gen_dep '
		llvm-core/clang:${LLVM_SLOT}=
	')
"
DEPEND="${RDEPEND}
	dev-util/vulkan-headers
	$(llvm_gen_dep '
		llvm-core/llvm:${LLVM_SLOT}
	')
"
BDEPEND="
	>=dev-build/cmake-3.25
	$(python_gen_cond_dep '
		dev-python/packaging[${PYTHON_USEDEP}]
	')
"

pkg_setup() {
	python-single-r1_pkg_setup
	llvm-r2_pkg_setup
}

src_configure() {
	local mycmakeargs=(
		-DBUILD_TESTS=OFF
		-DFORCE_LIMITED_API=OFF
		-DMODULES="Core;Gui;Widgets;Network;DBus;Qml;Quick"
		-DCMAKE_DISABLE_FIND_PACKAGE_Qt6Designer=ON
		-DCMAKE_DISABLE_FIND_PACKAGE_Qt6RemoteObjects=ON
		-DPython_EXECUTABLE="${PYTHON}"
		-DPYTHON_SITE_PACKAGES="$(python_get_sitedir)"
		-DClang_DIR="$(get_llvm_prefix)/$(get_libdir)/cmake/clang"
		-DLIB_SUFFIX="$(get_libdir | cut -c4-)"
	)
	cmake_src_configure
}
