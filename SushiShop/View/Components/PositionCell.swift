//
//  PositionCell.swift
//  SushiShop
//
//  Created by user on 03.04.2023.
//

import SwiftUI

struct PositionCell: View {
    
    let position: Position
    
    
    var body: some View {
        
        HStack {
            Text(position.product.title)
                .fontWeight(.bold)
            Spacer() 
            Text("\(position.count) pcs.")
            Text("\(position.cost) ₴")
                .frame(width: 85, alignment: .trailing)
        }.padding(.horizontal)
    }
}

struct PositionCell_Previews: PreviewProvider {
    static var previews: some View {
        PositionCell(
            position: Position(id: UUID().uuidString, product: Product(id: UUID().uuidString,
                                                                       title: "Japan Dragon",
                                                                       imageUrl: "sushiPH",
                                                                       price: 950,
                                                                       descript: "lalala"),
                               count: 3)
        )
    }
}
