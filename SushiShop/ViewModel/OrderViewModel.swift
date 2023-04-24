//
//  OrderViewModel.swift
//  SushiShop
//
//  Created by user on 12.04.2023.
//

import Foundation

class OrderViewModel: ObservableObject {
    
    @Published var order: Order
    @Published var user = RandomUser(id: "", name: "", phone: 0, address: "")
    
    init(order: Order) {
        self.order = order
    }
    
    func getUserData() {
        DatabaseService.shared.getProfile(by: order.userID) { result in
            switch result {
                
            case .success(let user):
                self.user = user
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
