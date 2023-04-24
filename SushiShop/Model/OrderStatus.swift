//
//  OrderStatus.swift
//  SushiShop
//
//  Created by user on 08.04.2023.
//

import Foundation

enum OrderStatus: String, CaseIterable {
    case new = "New"
    case cooking = "Prepare"
    case delivery = "Delivery"
    case completed = "Complete"
    case cancelled = "Canceled"
    

}
