platform "el-8-x86_64" do |plat|
  plat.servicedir "/usr/lib/systemd/system"
  plat.defaultdir "/etc/sysconfig"
  plat.servicetype "systemd"

  packages = %w[
    autoconf automake createrepo gcc gcc-c++ java-1.8.0-openjdk-devel cmake
    libsepol libsepol-devel libselinux-devel make pkgconfig readline-devel
    rsync rpm-build rpm-libs rpm-sign rpmdevtools swig yum-utils zlib-devel
    systemtap-sdt-devel
  ]

  plat.provision_with("dnf install -y --allowerasing #{packages.join(' ')}")
  plat.install_build_dependencies_with 'dnf install -y --allowerasing'
  plat.vmpooler_template "redhat-8-x86_64"
end
