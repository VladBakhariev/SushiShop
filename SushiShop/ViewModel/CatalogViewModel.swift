//
//  CatalogViewModel.swift
//  SushiShop
//
//  Created by user on 02.04.2023.
//

import Foundation

class CatalogViewModel: ObservableObject {
    
    static let shared = CatalogViewModel()
    
    var popularProducts = [
        Product(id: "1",
                title: "Japan Dragon",
                imageUrl: "Not found",
                price: 950,
                descript: "The trendiest sushi experience"),
        Product(id: "2",
                title: "Ocean Breeze",
                imageUrl: "Not found",
                price: 1150,
                descript: "The freshest seafood"),
        Product(id: "3",
                title: "Zen Garden",
                imageUrl: "Not found",
                price: 660,
                descript: "The perfect balance"),
        Product(id: "4",
                title: "Tokyo Nights",
                imageUrl: "Not found",
                price: 880,
                descript: "The ultimate flavor explosion"),
        Product(id: "4",
                title: "Sakura Blossom",
                imageUrl: "Not found",
                price: 1550,
                descript: "The most elegant sushi set")
    ]
    
    var sushi = [
        Product(id: "1",
                title: "Japan Dragon",
                imageUrl: "Not found",
                price: 950,
                descript: "The trendiest sushi experience"),
        Product(id: "2",
                title: "Ocean Breeze",
                imageUrl: "Not found",
                price: 1150,
                descript: "The freshest seafood"),
        Product(id: "3",
                title: "Zen Garden",
                imageUrl: "Not found",
                price: 660,
                descript: "The perfect balance"),
        Product(id: "4",
                title: "Tokyo Nights",
                imageUrl: "Not found",
                price: 880,
                descript: "The ultimate flavor explosion"),
        Product(id: "4",
                title: "Sakura Blossom",
                imageUrl: "Not found",
                price: 1550,
                descript: "The most elegant sushi set")
    ]
    
    func getProducts() {
        DatabaseService.shared.getProducts { result in
            switch result {
                
            case .success(let products):
                self.sushi = products
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}
