//
//  AuthService.swift
//  SushiShop
//
//  Created by user on 04.04.2023.
//

import Foundation
import FirebaseAuth

class AuthService {
    
    //создаем singletone
    static let shared = AuthService()
    
    private init() { }
    
    //тут будет храниться таблица с users
    private let auth = Auth.auth()
    
    var currentUser: User? {
        return auth.currentUser
    }
    
    func signOut() {
        try! auth.signOut()
    }
    
    //создаем метод для регистрации нового пользователя
    func signUP(email: String,
                password: String,
                completion: @escaping (Result<User, Error>) -> ()) {
        
        auth.createUser(withEmail: email,
                        password: password) { result, error in
            
            if let result = result {
                
                let randomUser = RandomUser(id: result.user.uid,
                                            name: "",
                                            phone: 0,
                                            address: "")
                
                DatabaseService.shared.setProfile(user: randomUser) { resultDB in
                    switch resultDB {
                        
                    case .success(_):
                        completion(.success(result.user))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
            
            } else if let error = error {
                completion(.failure(error))
            }
        }
    }
    
    func signIn(email: String,
                password: String,
                completion: @escaping (Result<User, Error>) -> ()) {
        
        auth.signIn(withEmail: email, password: password) { result, error in
            if let result = result {
                completion(.success(result.user))
            } else if let error = error {
                completion(.failure(error))
            }
        }
    }
    
}
