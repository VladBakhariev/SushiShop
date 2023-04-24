//
//  AddProductView.swift
//  SushiShop
//
//  Created by user on 12.04.2023.
//

import SwiftUI

struct AddProductView: View {
    
    @State private var showImagePicker = false
    @State private var image = UIImage(named: "sushishop")!
    @State private var title: String = ""
    @State private var descript: String = ""
    @State private var price: Int? = nil
    @Environment (\.dismiss) var dismiss
    
    
    var body: some View {
        VStack {
            Text("Add product")
                .font(.title2.bold())
            Image(uiImage: image)
                .resizable()
                .frame(maxWidth: .infinity, minHeight: 300, maxHeight: 320)
                .aspectRatio(contentMode: .fit)
                .onTapGesture {
                    showImagePicker.toggle()
                }
                .cornerRadius(24)
            TextField("Product name", text: $title)
                .padding()
            TextField("Product price", value: $price, format: .number)
                .keyboardType(.numberPad)
                .padding()
            TextField("Product description", text: $descript)
                .padding()
            
            Button {
                guard let price = price else {
                    print("Unable to extract price from TextField")
                    return
                }
                let product = Product(id: UUID().uuidString, title: title, price: price, descript: descript)
                guard let imageData = image.jpegData(compressionQuality: 0.15) else { return }
                DatabaseService.shared.setProduct(product: product, image: imageData) { result in
                    switch result {
                        
                    case .success(let product):
                        print(product.title)
                        dismiss()
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
                
            } label: {
                Text("Save")
                    .padding()
                    .padding(.horizontal)
                    .background(.blue)
                    .foregroundColor(.white)
                    .cornerRadius(16)
            }
            
            Spacer()

        }
        .padding()
        .sheet(isPresented: $showImagePicker) {
            ImagePicker(sourceType: .photoLibrary, selectedImage: $image)
        }
    }
}

struct AddProductView_Previews: PreviewProvider {
    static var previews: some View {
        AddProductView()
    }
}
