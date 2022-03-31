//
//  GarbageMateApp.swift
//  GarbageMate
//
//  Created by Iker on 18/11/21.
//

import SwiftUI
import Cocoa

@main
struct GarbageMateApp: App {
    
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        Settings {
            Text("")
        }
    }
    
}


