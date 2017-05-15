class nativescript-android-sdk < Formula
  version '22.0.1'
  sha256 "0a3fcda0eb90195f1d9926ea756307d38f6801e10289afe14bd15d0c155cd1ee"
  
  url "https://dl.google.com/android/repository/tools_r#{version}-macosx.zip"
  name 'nativescript-android-sdk'
  homepage 'https://developer.android.com/index.html'

  build_tools_version = '22.0.1'

  binary "#{staged_path}/build-tools/#{build_tools_version}/aapt"
  binary "#{staged_path}/build-tools/#{build_tools_version}/aapt2"
  binary "#{staged_path}/build-tools/#{build_tools_version}/aidl"
  binary "#{staged_path}/build-tools/#{build_tools_version}/apksigner"
  binary "#{staged_path}/build-tools/#{build_tools_version}/dexdump"
  binary "#{staged_path}/build-tools/#{build_tools_version}/dx"
  binary "#{staged_path}/build-tools/#{build_tools_version}/llvm-rs-cc"
  binary "#{staged_path}/build-tools/#{build_tools_version}/zipalign"
  binary "#{staged_path}/emulator/emulator"
  binary "#{staged_path}/emulator/emulator-check"
  binary "#{staged_path}/emulator/emulator64-arm"
  binary "#{staged_path}/emulator/emulator64-mips"
  binary "#{staged_path}/emulator/emulator64-x86"
  binary "#{staged_path}/platform-tools/adb"
  binary "#{staged_path}/platform-tools/dmtracedump"
  binary "#{staged_path}/platform-tools/etc1tool"
  binary "#{staged_path}/platform-tools/fastboot"
  binary "#{staged_path}/platform-tools/hprof-conv"
  binary "#{staged_path}/tools/android"
  binary "#{staged_path}/tools/bin/avdmanager"
  binary "#{staged_path}/tools/bin/lint"
  binary "#{staged_path}/tools/bin/monkeyrunner"
  binary "#{staged_path}/tools/bin/sdkmanager"
  binary "#{staged_path}/tools/mksdcard"
  binary "#{staged_path}/tools/monitor"

  preflight do
    system_command "#{staged_path}/tools/bin/sdkmanager", args: ['tools', 'platform-tools', "build-tools;#{build_tools_version}"], input: 'y'
  end

  postflight do
    FileUtils.ln_sf(staged_path.to_s, "#{HOMEBREW_PREFIX}/share/android-sdk")
  end

  uninstall_postflight do
    FileUtils.rm("#{HOMEBREW_PREFIX}/share/android-sdk")
  end

  caveats <<-EOS.undent
    We will install android-sdk-tools, platform-tools, and build-tools for you.
    You can control android sdk packages via the sdkmanager command.
    You may want to add to your profile:
      'export ANDROID_SDK_ROOT=#{HOMEBREW_PREFIX}/share/android-sdk'
    This operation may take up to 10 minutes depending on your internet connection.
    Please, be patient.
  EOS
end