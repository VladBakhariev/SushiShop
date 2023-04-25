//
//  Product.swift
//  SushiShop
//
//  Created by user on 02.04.2023.
//

import Foundation
import FirebaseFirestore

struct Product {
      
    var id: String
    var title: String
    var imageUrl: String = ""
    var price: Int
    var descript: String
    
//    var ordersCount: Int
//    var isRecommend: Bool
    
    var representation: [String: Any] {
        
        var repres = [String: Any] ()
        repres["id"] = self.id
        repres["title"] = self.title
        repres["price"] = self.price
        repres["descript"] = self.descript
        
        return repres
    }
    
    internal init(id: String = UUID().uuidString,
                  title: String,
                  imageUrl: String = "",
                  price: Int,
                  descript: String) {
        self.id = id
        self.title = title
        self.imageUrl = imageUrl
        self.price = price
        self.descript = descript
    }
    
}

