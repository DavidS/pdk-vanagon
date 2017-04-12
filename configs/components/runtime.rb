# This component exists to link in the gcc and stdc++ runtime libraries.
component "runtime" do |pkg, settings, platform|
  if platform.is_windows?
    lib_type = platform.architecture == "x64" ? "seh" : "sjlj"
    ["libgcc_s_#{lib_type}-1.dll", 'libstdc++-6.dll', 'libwinpthread-1.dll'].each do |dll|
      pkg.install_file File.join(settings[:gcc_bindir], dll), File.join(settings[:bindir], dll)
    end

    # Curl is dynamically linking against zlib, so we need to include this file until we
    # update curl to statically link against zlib
    pkg.build_requires "pl-zlib-#{platform.architecture}"
    pkg.install_file "#{settings[:tools_root]}/bin/zlib1.dll", "#{settings[:bindir]}/zlib1.dll"
  elsif platform.is_osx?

    # Do nothing

  else # Linux and Solaris systems
    libdir = "/opt/pl-build-tools/lib64"
    pkg.add_source "file://resources/files/runtime/runtime.sh"
    pkg.install do
      "bash runtime.sh #{libdir}"
    end
  end
end
