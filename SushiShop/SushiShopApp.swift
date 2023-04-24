//
//  SushiShopApp.swift
//  SushiShop
//
//  Created by user on 01.04.2023.
//

import SwiftUI
import Firebase

let screen = UIScreen.main.bounds

@main
struct SushiShopApp: App {
    
    @UIApplicationDelegateAdaptor private var appDelegate: AppDelegate
    
    var body: some Scene {
        WindowGroup {
            
            if let user = AuthService.shared.currentUser {
                if user.uid == "KWqbzHS20FZxEBP67Lpg1R4K5op1" {
                    AdminOrdersView()
                } else {
                    let viewModel = MainTabBarViewModel(user: user)
                    MainTabBar(viewModel: viewModel)
                }
                
            } else {
                AuthView()
            }
        }
    }
    //for integration firebase to xCode (using UIKit)
    class AppDelegate: NSObject, UIApplicationDelegate {
        func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOption:
        [UIApplication.LaunchOptionsKey : Any]? = nil ) -> Bool {
            
            FirebaseApp.configure()
            print("App Delegate")
            return true
        }
    }
}
