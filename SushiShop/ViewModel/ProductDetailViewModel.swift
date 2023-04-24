//
//  ProductDetailViewModel.swift
//  SushiShop
//
//  Created by user on 03.04.2023.
//

import Foundation

class ProductDetailViewModel: ObservableObject {
    
    @Published var product: Product
    @Published var sizes = ["Small", "Large", "Extra"]
    @Published var count = 0
    
    init(product: Product) {
        self.product = product
    }
    
    func getPrice(size: String) -> Int {
        
        switch size {
        case "Small": return product.price
        case "Large": return Int(Double(product.price) * 1.25)
        case "Extra": return Int(Double(product.price) * 1.5)
        default: return 0
        }
        
    }

}
