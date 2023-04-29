import 'dart:ffi';
import 'dart:io';

import 'package:win32/win32.dart';

class Wallpaper {
  static void set(File wallpaperFile) {
    final hr = CoInitializeEx(
        nullptr, COINIT_APARTMENTTHREADED | COINIT_DISABLE_OLE1DDE);
    if (FAILED(hr)) throw WindowsException(hr);

    final wallpaper = DesktopWallpaper.createInstance();

    final pathPtr = TEXT(wallpaperFile.path);
    wallpaper.setWallpaper(nullptr, pathPtr);
    if (FAILED(hr)) throw WindowsException(hr);

    free(pathPtr);
    free(wallpaper.ptr);

    CoUninitialize();
  }
}
