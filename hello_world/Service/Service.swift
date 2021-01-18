//
//  Service.swift
//  hello_world
//
//  Created by tientran on 26/12/2020.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

let DB_REF = Firestore.firestore()
let USER_REF = DB_REF.collection("users")
let DRIVER_LOCATION_REF = DB_REF.collection("driver-locations")

struct Service {
    
    static let share = Service()
    let uid = Auth.auth().currentUser?.uid
    
    
    func fetchUserData( completion : @escaping (User) -> Void )  {
        
        USER_REF.document(uid!).getDocument { (document, err) in
            if let document = document, document.exists {
                
                guard let dictionary = document.data() else { return }
                let user  = User(user: dictionary)
                print("Document data: \(dictionary)")
                completion(user)
                
            } else {
                print("Document does not exist")
            }
        }
        
    }
    
}
