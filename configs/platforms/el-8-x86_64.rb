platform "el-8-x86_64" do |plat|
  plat.inherit_from_default
  plat.clear_provisioning

  packages = %w[gcc gcc-c++ autoconf automake createrepo rsync cmake-3.11.4 make rpm-libs rpm-build rpm-sign libtool]
  plat.provision_with "dnf install -y --allowerasing #{packages.join(' ')}"
end
