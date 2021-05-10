//
//  User.swift
//  Introtruce
//
//  Created by Anis on 10/05/21.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift


struct User: Codable, Equatable {
    let uid : String
    let first_name: String
    let last_name: String
    let dob: String
    let gender: String
    let country: String
    let state: String
    let home_town: String
    let phone_number: String
    let tel_number: String
    let profileLink: String?
    @ServerTimestamp var createdDate = Date()
    
}

func saveUserFirestore(user: User) {
    do {
        try db.collection(K.FStore.UsersCollection).document(user.phone_number).setData(
            [K.User.uid: user.uid,
             K.User.first_name: user.first_name,
             K.User.last_name: user.last_name,
             K.User.dob: user.dob,
             K.User.gender: user.gender,
             K.User.country: user.country,
             K.User.state: user.state,
             K.User.home_town: user.home_town,
             K.User.phone_number: user.phone_number,
             K.User.tel_number: user.tel_number,
             K.User.profileLink: user.profileLink ?? "",
             K.User.createdDate: user.createdDate!
            ]
        )
    } catch let error {
        print(error.localizedDescription, "adding user")
    }
}

func checkUserFirestore(user: User) -> Bool {
    var val = false
    db.collection(K.FStore.UsersCollection).document(user.phone_number).getDocument(completion: { (document, error) in
        if let document = document, document.exists {
            val = true
            print("document already exists")
        } else {
            val = false
        }
    })
    return val
}
