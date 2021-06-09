//
//  FilabusiApp.swift
//  Filabusi
//
//  Created by Munyaradzi Hove on 2021-05-21.
//

import SwiftUI
import UIKit
import FirebaseCore
import GooglePlaces
import GoogleMaps

class AppDelegate: UIResponder, UIApplicationDelegate{
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        GMSPlacesClient.provideAPIKey("AIzaSyDFvEiSFb2rqJV4kOYkxYZQ5nUhtYLR_Zw")
        GMSServices.provideAPIKey("AIzaSyDFvEiSFb2rqJV4kOYkxYZQ5nUhtYLR_Zw")
        return true
    }
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
           // Called when a new scene session is being created.
           // Use this method to select a configuration to create the new scene with.
           return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
           // Called when the user discards a scene session.
           // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
           // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
}

@main
struct FilabusiApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @EnvironmentObject var viewRouter: ViewRouter
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(ViewRouter())
                .preferredColorScheme(.light)
        }
    }
}
