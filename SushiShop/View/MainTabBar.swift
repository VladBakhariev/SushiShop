//
//  MainTabBar.swift
//  SushiShop
//
//  Created by user on 02.04.2023.
//

import SwiftUI

struct MainTabBar: View {
    
    var viewModel: MainTabBarViewModel
    var body: some View {
        
        TabView {
            
            NavigationView {
                CatalogView()
            }
                .tabItem {
                    VStack {
                        Image(systemName: "menucard")
                        Text("Сatalog")
                    }
                }
            
            CartView(viewModel: CartViewModel.shared)
                .tabItem {
                    VStack {
                        Image(systemName: "cart")
                        Text("Cart")
                    }
                }
            ProfileView(viewModel: ProfileViewModel(profile: RandomUser(id: "",
                                                                          name: "",
                                                                          phone: 000000000,
                                                                          address: "")))
                .tabItem {
                    VStack {
                        Image(systemName: "person.circle")
                        Text("Profile")
                    }
                }
        }
        
    }
}

//struct MainTabBar_Previews: PreviewProvider {
//    static var previews: some View {
//        MainTabBar(viewModel: MainTabBarViewModel(user: User)
//    }
//}
