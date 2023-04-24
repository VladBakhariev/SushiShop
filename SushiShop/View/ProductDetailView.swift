//
//  ProductDetailView.swift
//  SushiShop
//
//  Created by user on 02.04.2023.
//

import SwiftUI

struct ProductDetailView: View {
    
    var viewModel: ProductDetailViewModel
    @State var size = "Small"
    @State var count = 1
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        
        VStack {
            VStack(alignment: .leading) {
                
                Image("sushiPH")
                    .resizable()
                    .frame(maxWidth: .infinity, maxHeight: 260)
                
                HStack {
                    Text("\(viewModel.product.title)!")
                        .font(.title2.bold())
                    Spacer()
                    Text("\(viewModel.getPrice(size: self.size)) ₴")
                        .font(.title2)
                }.padding(.horizontal)
                Text("\(viewModel.product.descript)")
                    .padding(.horizontal)
                    .padding(.vertical, 4)
                
                HStack {
                    Stepper("Quantity", value: $count, in: 1...10)
                    
                    Text("\(self.count)")
                        .padding(.leading, 32)
                    
                }.padding(.horizontal)
  
                Picker("Sushi size", selection: $size) {
                    
                    ForEach(viewModel.sizes, id: \.self) { item in
                        Text(item)
                    }
                }.pickerStyle(.segmented)
                    .padding()
            }
            Button {
                var position = Position(id: UUID().uuidString,
                                        product: viewModel.product,
                                        count: self.count)
                
                position.product.price = viewModel.getPrice(size: size)
                CartViewModel.shared.addPosition(position)
                presentationMode.wrappedValue.dismiss()
                
                
            } label: {
                Text("Add to cart!")
                    .padding()
                    .padding(.horizontal, 50)
                    .foregroundColor(.white)
                    .font(.title2.bold())
                    .background(LinearGradient(colors: [Color("orange"),Color("purple")], startPoint: .leading, endPoint: .trailing))
                    .cornerRadius(30)
            
            }

            
            Spacer()
        }
    }
}

struct ProductDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ProductDetailView(viewModel: ProductDetailViewModel(product: Product (id: "1",
                                                            title: "Japan Dragon",
                                                            imageUrl: "Not found",
                                                            price: 950,
                                                            descript: "The trendiest sushi experience")
        ))
    }
}
