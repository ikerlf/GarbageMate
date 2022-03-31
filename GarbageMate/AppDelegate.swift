//
//  AppDelegate.swift
//  GarbageMate
//
//  Created by Iker on 31/3/22.
//

import Cocoa
import Foundation
import SwiftUI

class AppDelegate: NSObject, NSApplicationDelegate {
    
    private lazy var statusBarItem: NSStatusItem = {
        NSStatusBar.system.statusItem(withLength: 22)
    }()
    
    private lazy var contentView = GarbageMateView(delegate: self)
    
    private lazy var view: NSHostingView<GarbageMateView> = {
        let view = NSHostingView(rootView: contentView)
        view.frame = NSRect(x: 0, y: 0, width: 116, height: 58)
        return view
    }()
    
    private lazy var menu: NSMenu = {
       let menu = NSMenu()
        menu.addItem(menuItem)
        return menu
    }()
    
    private lazy var menuItem: NSMenuItem = {
        let item = NSMenuItem()
        item.view = view
        return item
    }()
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        self.statusBarItem.menu = menu
        self.statusBarItem.button?.image = NSImage(systemSymbolName: "trash", accessibilityDescription: nil)
        NSApplication.shared.setActivationPolicy(.accessory)
        DispatchQueue.main.async {
            NSApplication.shared.activate(ignoringOtherApps: true)
            NSApplication.shared.windows.first!.makeKeyAndOrderFront(self)
        }
         
    }
    
    func collapse() {
        self.statusBarItem.menu?.cancelTracking()
    }
    
}
