//
//  Catalog.swift
//  SushiShop
//
//  Created by user on 02.04.2023.
//

import SwiftUI

struct CatalogView: View {
    
    let layoutForPopular = [GridItem(.adaptive(minimum: screen.width / 2.2))]
    let layoutForSushi = [GridItem(.adaptive(minimum: screen.width / 2.4))]
    
    
    var body: some View {
        
        ScrollView(.vertical, showsIndicators: false) {
            Section("Popular") {
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHGrid(rows: layoutForSushi, spacing: 16) {
                        ForEach(CatalogViewModel.shared.popularProducts, id: \.id) { item in
                            
                            NavigationLink {
                                
                                let viewModel = ProductDetailViewModel(product: item)
                                
                                ProductDetailView(viewModel: viewModel)
                            } label: {
                                ProductCell(product: item)
                                    .foregroundColor(.black)
                            }
                        }
                    }.padding()
                }
            }
            
            Section("Sushi") {
                ScrollView(.vertical, showsIndicators: false) {
                    LazyVGrid(columns: layoutForSushi, spacing: 16) {
                        ForEach(CatalogViewModel.shared.sushi, id: \.id) { item in
                            
                            NavigationLink {
                                
                                let viewModel = ProductDetailViewModel(product: item)
                                
                                ProductDetailView(viewModel: viewModel)
                            } label: {
                                ProductCell(product: item)
                                    .foregroundColor(.black)
                            }
                        }
                    }.padding()
                }
            }

        }.navigationTitle(Text("Catalog"))
            .onAppear {
                CatalogViewModel.shared.getProducts()
            }
    }
}

struct Catalog_Previews: PreviewProvider {
    static var previews: some View {
        CatalogView()
    }
}
