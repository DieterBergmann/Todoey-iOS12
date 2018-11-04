//
//  AppDelegate.swift
//  Todoey-iOS12
//
//  Created by Dieter Bergmann on 13.10.18.
//  Copyright © 2018 Dieter Bergmann. All rights reserved.
//

import UIKit
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
//        print(Realm.Configuration.defaultConfiguration.fileURL)
        
        // Nicht nötig, bleibt nur um zu sehen ob beim Initialisieren von realm ein Fehler auftritt
        do {
            _ = try Realm()
        } catch {
            print("Error initialising new realm, \(error)")
        }

        return true
    }
}

