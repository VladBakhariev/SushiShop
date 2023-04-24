//
//  ProfileView.swift
//  SushiShop
//
//  Created by user on 02.04.2023.
//

import SwiftUI

struct ProfileView: View {
    
    @State var isAvaAlertPresented = false
    @State var isQuitAlertPresented = false
    @State var isAuthViewPresented = false
    
    @StateObject var viewModel: ProfileViewModel
    
    var body: some View {
        
        VStack(alignment: .center, spacing: 20) {
            HStack(spacing: 16) {
                Image("user")
                    .resizable()
                    .frame(width: 80, height: 80)
                    .padding(8)
                    .background(Color("corral"))
                    .clipShape(Circle())
                    .onTapGesture {
                        isAvaAlertPresented.toggle()
                    }
                    .confirmationDialog("Find a photo", isPresented: $isAvaAlertPresented) {
                        Button {
                            print("Liberary")
                        } label: {
                            Text("Gallery")
                        }
                        Button {
                            print("Camera")
                        } label: {
                            Text("Camera")
                        }
                    }

                VStack(alignment: .leading, spacing: 12) {
                    TextField("Name", text: $viewModel.profile.name)
                        .font(.body.bold())
                    
                    HStack {
                        Text("+380")
                        TextField("Phone number",
                                  value: $viewModel.profile.phone,
                                  format: IntegerFormatStyle.number)
                    }
                }
            }.padding()
            
            VStack(alignment: .leading, spacing: 8) {
                Text("Delivery address: ")
                    .bold()
                
                TextField("Your adress", text: $viewModel.profile.address)
            }.padding(.horizontal)
            
            
            //Таблица с заказами
            List {
                if viewModel.orders.count == 0 {
                    Text("Your order will here")
                } else {
                    ForEach(viewModel.orders, id: \.id) { order in
                        OrderCell(order: order)
                    }
                }
            
            }.listStyle(.plain)
            
            Button {
                isQuitAlertPresented.toggle()
            } label: {
                Text("Quit")
                    .padding()
                    .padding(.horizontal, 30)
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(20)
            }.padding()
                .confirmationDialog("Are your sure?", isPresented: $isQuitAlertPresented) {
                    Button {
                        isAuthViewPresented.toggle()
                    } label: {
                        Text("Yes")
                    }

                }
                
                .fullScreenCover(isPresented: $isAuthViewPresented, onDismiss: nil) {
                    AuthView()
                }

        }
        .onSubmit {
            viewModel.setProfile()
        }
        .onAppear {
            self.viewModel.getProfile()
            self.viewModel.getOrders()
        }
        
    }
}
struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(viewModel: ProfileViewModel(profile: RandomUser(id: "",
                                                                    name: "Jack Nicklson",
                                                                    phone: 632122277,
                                                                    address: "Kyiv, National str.")))
    }
}
