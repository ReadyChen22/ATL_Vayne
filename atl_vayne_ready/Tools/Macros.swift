//
//  Macros.swift
//  atl_vayne_ready
//
//  Created by BruceAppRD on 2023/3/12.
//

import Foundation

// dLog and aLog macros to abbreviate NSLog.
// Use like this:
//
//   dLog("Log this!")
//
#if DEBUG
    func dLog(_ message: Any, filename: String = #file, function: String = #function, line: Int = #line) {
        // Set it in the "Swift Compiler - Custom Flags" section
        // "Other Swift Flags" line.
        // You add the DEBUG symbol with the "-D DEBUG" entry.
        let queue = Thread.isMainThread ? "UI" : "BG"
        NSLog("%@","[\(queue)][\((filename as NSString).lastPathComponent):\(line)] \(function) \(message)")
    }
#else
    func dLog(_ message: Any, filename: String = #file, function: String = #function, line: Int = #line) {
    }
#endif
    func aLog(_ message: Any, filename: String = #file, function: String = #function, line: Int = #line) {
        let queue = Thread.isMainThread ? "UI" : "BG"
        NSLog("%@","[\(queue)][\((filename as NSString).lastPathComponent):\(line)] \(function) \(message)")
    }
