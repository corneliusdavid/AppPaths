# AppPaths
Simple Delphi cross-platform app to list the standard paths available on various platforms.
Uses the `System.IOUtils` unit to show the value of several `TPath` functions.

For example: `TPath.GetHomePath`, `TPath.GetDocumentsPath`, etc.

Run it on different platforms--you may be surprised what's available and what's not!

Expanded from the sample project included with the code for the book [Fearless Cross-Platform Development with Delphi](https://www.packtpub.com/product/fearless-cross-platform-development-with-delphi/9781800203822).

See the original GitHub project: https://github.com/PacktPublishing/Fearless-Cross-Platform-Development-with-Delphi/tree/master/Chapter15/01_AppPaths

Here's a screenshot of it running on a Mac:

![AppPaths running on a Mac](https://github.com/corneliusdavid/AppPaths/blob/main/AppPaths_MacOSX.png)

If you click on a folder, you'll get a list of files in that folder (if there are any). For example, here are the files under the Release folder for the Win32 version:

![AppPaths running on Win32 showing Release files](https://github.com/corneliusdavid/AppPaths/blob/main/AppPaths_Win32_ReleaseFolder.png)

Written in _Delphi 11 Alexandria_.
