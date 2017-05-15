cask 'nativescript-android-sdk' do
  version '22.0.1'
  sha256 '0a3fcda0eb90195f1d9926ea756307d38f6801e10289afe14bd15d0c155cd1ee'

  # google.com/android/repository/tools_r was verified as official when first introduced to the cask
  url "https://dl.google.com/android/repository/tools_r#{version}-macosx.zip"
  name 'NativeScript - Android SDK'
  homepage 'https://developer.android.com/index.html'

  build_tools_version = '22.0.1'
  path = 'android-sdk'

  binary "#{path}/build-tools/#{build_tools_version}/aapt"
  binary "#{path}/build-tools/#{build_tools_version}/aapt2"
  binary "#{path}/build-tools/#{build_tools_version}/aidl"
  binary "#{path}/build-tools/#{build_tools_version}/apksigner"
  binary "#{path}/build-tools/#{build_tools_version}/dexdump"
  binary "#{path}/build-tools/#{build_tools_version}/dx"
  binary "#{path}/build-tools/#{build_tools_version}/llvm-rs-cc"
  binary "#{path}/build-tools/#{build_tools_version}/zipalign"
  binary "#{path}/emulator/emulator"
  binary "#{path}/emulator/emulator-check"
  binary "#{path}/emulator/emulator64-arm"
  binary "#{path}/emulator/emulator64-mips"
  binary "#{path}/emulator/emulator64-x86"
  binary "#{path}/platform-tools/adb"
  binary "#{path}/platform-tools/dmtracedump"
  binary "#{path}/platform-tools/etc1tool"
  binary "#{path}/platform-tools/fastboot"
  binary "#{path}/platform-tools/hprof-conv"
  binary "#{path}/tools/android"
  binary "#{path}/tools/bin/avdmanager"
  binary "#{path}/tools/bin/lint"
  binary "#{path}/tools/bin/monkeyrunner"
  binary "#{path}/tools/bin/sdkmanager"
  binary "#{path}/tools/mksdcard"
  binary "#{path}/tools/monitor"

  preflight do
    system_command "#{path}/tools/bin/sdkmanager", args: ['tools', 'platform-tools', "build-tools;#{build_tools_version}"], input: 'y'
  end

  postflight do
    FileUtils.ln_sf(path.to_s, "#{HOMEBREW_PREFIX}/share/android-sdk")
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