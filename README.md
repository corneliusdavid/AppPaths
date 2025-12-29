# AppPaths
Simple Delphi cross-platform app to list the standard paths available on various platforms.
Uses the `System.IOUtils` unit to show the value of several `TPath` functions.

For example: `TPath.GetHomePath`, `TPath.GetDocumentsPath`, etc.

Run it on different platforms--you may be surprised what's available and what's not!

Expanded from the sample project included with the code for the book [Fearless Cross-Platform Development with Delphi](https://www.packtpub.com/product/fearless-cross-platform-development-with-delphi/9781800203822).

See the original GitHub project: https://github.com/PacktPublishing/Fearless-Cross-Platform-Development-with-Delphi/tree/master/Chapter15/01_AppPaths

Here's a screenshot of it running on a Mac:

![AppPaths running on a Mac](https://github.com/corneliusdavid/AppPaths/blob/main/AppPaths_MacOSX_D12.png)

If you click on a folder, you'll get a list of files in that folder (if there are any). For example, here are the files under the Release folder for the Win32 version:

![AppPaths running on Win32 showing Release files](https://github.com/corneliusdavid/AppPaths/blob/main/AppPaths_Win32_ReleaseFolder.png)

if you click the cirled "i" button in the lower-left corner, an Info screen pops up with a link to the GitHub page:

![AppPaths running on Android showing the Info page](https://github.com/corneliusdavid/AppPaths/blob/main/AppPaths_AndroidAbout.png)

Written in _Delphi 11 Alexandria_, upgraded to _Delphi 13 Florence_.

### Android Tip

To get this running on your Android phone, run `adb` from the `platform-tools` folder of your copy of Android SDK which your project is using. For me using Delphi 13 and its default Android SDK folders, that would be `C:\Users\Public\Documents\Embarcadero\Studio\37.0\CatalogRepository\AndroidSDK-37.0.57242.3601`. I added the `platform-tools` sub-folder to the PATH so I could run `adb.exe` easilly.

Once that is running, use `adb` to `connect` to your phone's IP address. I am using Wireless Debugging which meant I had to pair the devices first using `adb pair <IP-Address>:<Port> <Pairing-Code>` and _then_ use the `connect` command with the `IPAddress`:`Port`.

Hope that helps!
