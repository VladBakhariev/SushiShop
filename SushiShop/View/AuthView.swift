//
//  ContentView.swift
//  SushiShop
//
//  Created by user on 01.04.2023.
//

import SwiftUI

struct AuthView: View {
    
    @State private var isAuth = true
    
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var isTabViewShow = false
    @State private var isShowAlert = false
    @State private var alertMessage = ""
    
    var body: some View {
        
        VStack(spacing: 20) {
            Text(isAuth ? "Autorization" : "Сreate an account")
                .padding(isAuth ? 16 : 24)
                .padding(.horizontal, 30)
                .font(.title2.bold())
                .background(Color("whiteAlpha"))
                .cornerRadius(isAuth ? 30 : 60)
            
            VStack {
                TextField("Enter email", text: $email)
                    .padding()
                    .background(Color("whiteAlpha"))
                    .cornerRadius(12)
                    .padding(8)
                    .padding(.horizontal, 12)
                
                SecureField("Enter password", text: $password)
                    .padding()
                    .background(Color("whiteAlpha"))
                    .cornerRadius(12)
                    .padding(8)
                    .padding(.horizontal, 12)
                
                if !isAuth {
                    SecureField("Confirm password", text: $confirmPassword)
                        .padding()
                        .background(Color("whiteAlpha"))
                        .cornerRadius(12)
                        .padding(8)
                        .padding(.horizontal, 12)
                    
                }
                
                Button {
                    if isAuth {
                        print("Authorization of the user through Firebase")
                        
                        AuthService.shared.signIn(email: self.email,
                                                  password: self.password) { result in
                            switch result {
                            case .success(_):
                                isTabViewShow.toggle()
                            case .failure(let error):
                                alertMessage = "Authorisation error:\(error.localizedDescription)"
                                isShowAlert.toggle()
                            }
                        }
   
                    } else {
                        print("Сreate an account")
                        
                        guard password == confirmPassword else {
                            self.alertMessage = "Password mismatch!"
                            self.isShowAlert.toggle()
                            return
                        }
                        
                        AuthService.shared.signUP(email: self.email,
                                                  password: self.password) { result in
                            switch result {
                                
                            case .success(let user):
                                alertMessage = "You registered with email \(user.email!)"
                                self.isShowAlert.toggle()
                                self.email = ""
                                self.password = ""
                                self.confirmPassword = ""
                                self.isAuth.toggle()
                            case .failure(let error):
                                alertMessage = "Registration error \(error.localizedDescription)"
                            }
                        }
                    }
                    //print("Autorization")
                } label: {
                    Text(isAuth ? "Sign in" : "Registration")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(LinearGradient(colors: [Color("orange"),Color("purple")], startPoint: .leading, endPoint: .trailing))
                        .cornerRadius(12)
                        .padding(8)
                        .padding(.horizontal, 12)
                        .font(.title3.bold())
                        .foregroundColor(.black)
                }
                
                Button {
                    isAuth.toggle()
                } label: {
                    Text(isAuth ? "Сreate an account" : "Already have an account")
                        .padding(.horizontal)
                        .frame(maxWidth: .infinity)
                       // .background(LinearGradient(colors: [Color("orange"),Color("purple")], startPoint: .leading, endPoint: .trailing))
                        .cornerRadius(12)
                        .padding(8)
                        .padding(.horizontal, 12)
                        .font(.title3.bold())
                        .foregroundColor(Color("purple"))
                }
            }
            .padding()
            .padding(.top, 16)
            .background(Color("whiteAlpha"))
            .cornerRadius(24)
            .padding(isAuth ? 30 : 12)
            .alert(alertMessage,
                   isPresented: $isShowAlert) {
                Button { } label: {
                    Text("Ok")
                }
            }
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Image("bg")
                .ignoresSafeArea()
                .blur(radius: isAuth ? 0 : 5)
            )
            .animation(Animation.easeInOut(duration: 0.3), value: isAuth)
            .fullScreenCover(isPresented: $isTabViewShow) {
                
                if AuthService.shared.currentUser?.uid == "KWqbzHS20FZxEBP67Lpg1R4K5op1" {
                    AdminOrdersView()
                } else {
                    let mainTabBarViewModel = MainTabBarViewModel(user: AuthService.shared.currentUser!)
                    
                    MainTabBar(viewModel: mainTabBarViewModel)
                }
                
                
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        AuthView()
    }
}
