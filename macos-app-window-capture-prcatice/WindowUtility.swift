//
//  WindowUtility.swift
//  macos-app-window-capture-prcatice
//
//  Created by Takaaki Suzuki on 2021/03/23.
//

import Cocoa

class WindowUtility: NSObject {

  static func allActiveWindows() -> [WindowEntiry] {
    guard let windowInfos = CGWindowListCopyWindowInfo([.optionAll, .excludeDesktopElements], 0) else {
      return []
    }
    return (windowInfos as NSArray).compactMap { windowInfo -> WindowEntiry? in
      guard let info = windowInfo as? NSDictionary else {
        return nil
      }
      guard let windowAlpha = info[kCGWindowAlpha as String],
            (windowAlpha as! NSNumber).intValue > 0
      else {
        return nil
      }
      guard let windowBounds = info[kCGWindowBounds as String],
            let bounds = CGRect(dictionaryRepresentation: windowBounds as! CFDictionary),
            bounds.width > 100,
            bounds.height > 100
      else {
        return nil
      }
      guard let windowName = info[kCGWindowOwnerName as String] as? String
//            windowName != "Dock",
//            windowName != "Window Server"
      else {
        return nil
      }
      guard let windowId = info[kCGWindowNumber as String] as? NSNumber else {
        return nil
      }
      guard let preview = CGWindowListCreateImage(
        .null,
        .optionIncludingWindow,
        CGWindowID(truncating: windowId),
        [.nominalResolution]
      ) else {
        return nil
      }
      return WindowEntiry(windowId: CGWindowID(truncating: windowId), preview: preview, windowName: windowName)
    }
  }
}

struct WindowEntiry {
  let windowId: CGWindowID

  let preview: CGImage

  var windowName: String

  init(windowId: CGWindowID, preview: CGImage, windowName: String) {
    self.windowId = windowId
    self.windowName = windowName
    self.preview = preview
  }
}
