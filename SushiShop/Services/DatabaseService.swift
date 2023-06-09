//
//  DatabaseService.swift
//  SushiShop
//
//  Created by user on 04.04.2023.
//

import Foundation
import FirebaseFirestore

class DatabaseService {
    
    static let shared = DatabaseService()
    //db -> database
    private let db = Firestore.firestore()
    
    // создаем cсылку на кол-лекцию юзеров
    private var usersRef: CollectionReference { db.collection("users") }
    private var ordersRef: CollectionReference { db.collection("orders") }
    private var productsRef: CollectionReference { db.collection("products") }
    
    private init() { }
    
    func getPositions(by orderID: String, completion: @escaping (Result<[Position], Error>) -> ()) {
        
        let positionsRef = ordersRef.document(orderID).collection("positions")
        //qSnap - снимок какой-то части базы данных
        positionsRef.getDocuments { qSnap, error in
            if let querySnapshot = qSnap {
                var positions = [Position]()
                for doc in querySnapshot.documents {
                    if let position = Position(doc: doc) {
                        positions.append(position)
                    }
                }
                completion(.success(positions))
            } else if let error = error {
                completion(.failure(error))
            }
        }
    }
    
    func getOrders(by userID: String?,
                   completion: @escaping (Result<[Order], Error>) -> ()) {
        
        self.ordersRef.getDocuments { qSnap, error in
            if let qSnap = qSnap{
                var orders = [Order]()
                for doc in qSnap.documents {
                    if let userID = userID {
                        if let order = Order(doc: doc), order.userID == userID {
                            orders.append(order)
                        }
                    } else { // ветка админа
                        if let order = Order(doc: doc) {
                            orders.append(order)
                        }
                    }
                }
                completion(.success(orders))
            } else if let error = error {
                completion(.failure(error))
            }
        }
    }
    
    //метод отправляющий заказ в базу данных
    func setOrder(order: Order,
                  completion: @escaping (Result<Order, Error>) -> ()) {
        ordersRef.document(order.id).setData(order.representation) { error in
            if let error = error  {
                completion(.failure(error))
            } else {
                
                self.setPositions(to: order.id,
                                  positions: order.positions) { result in
                    switch result {
                    case .success(let positions):
                        print(positions.count)
                        completion(.success(order))
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            }
        }
    }
    
    //метод для позиций в заказе
    func setPositions(to orderID: String,
                      positions: [Position],
                      completion: @escaping (Result<[Position], Error>) -> ())  {
        
        let positionsRef = ordersRef.document(orderID).collection("positions")
        
        for position in positions {
            positionsRef.document(position.id).setData(position.representation)
        }
        
        completion(.success(positions))
        
    }
    
    func setProfile(user: RandomUser, completion: @escaping (Result<RandomUser, Error>) -> ()) {
        
        usersRef.document(user.id).setData(user.representation) { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(user))
            }
        }
        
    }
    func getProfile(by userID: String? = nil, completion: @escaping (Result<RandomUser, Error>) -> ()) {
        
        usersRef.document(userID != nil ? userID! : AuthService.shared.currentUser!.uid).getDocument { docSnapshot, error in
            
            guard let snap = docSnapshot else { return }
            guard let data = snap.data() else { return }
            
            guard let userName = data["name"] as? String else { return }
            guard let id = data["id"] as? String else { return }
            guard let phone = data["phone"] as? Int else { return }
            guard let address = data["address"] as? String else { return }
            
            let user = RandomUser(id: id, name: userName, phone: phone, address: address)
            
            completion(.success(user))
            
        }
    }
    
    func setProduct(product: Product, image: Data, completion: @escaping (Result<Product, Error>) -> ()) {
        StorageService.shared.upload(id: product.id, image: image) { result in
            
            switch result {
                
            case .success(let sizeInfo):
                print(sizeInfo)
                
                self.productsRef.document(product.id).setData(product.representation) { error in
                    if let error = error {
                        completion(.failure(error))
                    } else {
                        completion(.success(product))
                    }
                }
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
        
    }
}
    
    /*
     func getProfile(by userID: String? = nil, completion: @escaping (Result<RandomUser, Error>) -> ()) {
     if let userID = AuthService.shared.currentUser?.uid {
     let userDocRef = usersRef.document(userID)
     userDocRef.getDocument { docSnapshot, error in
     if let error = error {
     // Handle the error here
     completion(.failure(error))
     return
     }
     guard let snap = docSnapshot else { return }
     guard let data = snap.data() else { return }
     guard let userName = data["name"] as? String else { return }
     guard let id = data["id"] as? String else { return }
     guard let phone = data["phone"] as? Int else { return }
     guard let address = data["address"] as? String else { return }
     
     let user = RandomUser(id: id, name: userName, phone: phone, address: address)
     
     completion(.success(user))
     }
     } else {
     // Handle the case where the user ID is nil
     }
     }
     
     
     }
     */
