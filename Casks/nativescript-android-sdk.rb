cask 'nativescript-android-sdk' do
  version '22.0.1'
  sha256 '0a3fcda0eb90195f1d9926ea756307d38f6801e10289afe14bd15d0c155cd1ee'

  # google.com/android/repository/tools_r was verified as official when first introduced to the cask
  url "https://dl.google.com/android/repository/tools_r#{version}-macosx.zip"
  name 'NativeScript - Android SDK'
  homepage 'https://developer.android.com/index.html'

  build_tools_version = '22.0.1'
  path = 'android-sdk'

  binary "tools/android"

  postflight do
    FileUtils.ln_sf(path.to_s, "#{HOMEBREW_PREFIX}/Caskroom/android-sdk")
  end

  uninstall_postflight do
    FileUtils.rm("#{HOMEBREW_PREFIX}/Caskroom/android-sdk")
  end

  caveats <<-EOS.undent
    Now run android update sdk to get the old GUI and update the android SDKs.
    You may need to fix your profile with the following update:
      'export ANDROID_SDK_ROOT=#{HOMEBREW_PREFIX}/Caskroom/android-sdk'
    This operation may take up to 10 minutes depending on your internet connection.
    Please, be patient.
  EOS
end