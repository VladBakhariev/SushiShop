//
//  MainTabBarViewModel.swift
//  SushiShop
//
//  Created by user on 04.04.2023.
//

import Foundation
import FirebaseAuth

class MainTabBarViewModel: ObservableObject {
    
    @Published var user: User
    
    init(user: User) {
        self.user = user
    }
}

