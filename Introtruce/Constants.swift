//
//  Constants.swift
//  Introtruce
//
//  Created by Anis on 10/05/21.
//

import Foundation
import FirebaseFirestore

public let db = Firestore.firestore()

struct K {
    
    struct User {
        static let uid = "uid"
        static let first_name = "first_name"
        static let last_name = "last_name"
        static let dob = "dob"
        static let gender = "gender"
        static let country = "country"
        static let state = "state"
        static let home_town = "home_town"
        static let phone_number = "phone_number"
        static let tel_number = "tel_number"
        static let profileLink = "profileLink"
        static var createdDate = "createdDate"
    }
    
    struct StoryboardIDs {
        static let UsersListStoryboard = "UsersListStoryboard"
        static let RegistrationStoryboard = "RegistrationStoryboard"
    }
    
    struct FStore {
        static let UsersCollection = "UsersCollection"
    }
    
    struct CustomCells {
        static let UserCell = "UserCell"
    }
}
