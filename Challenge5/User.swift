//
//  User.swift
//  Challenge5
//
//  Created by Aryan Panwar on 27/07/24.
//

import Foundation



struct User: Hashable ,  Codable, Identifiable {
    
    let id: String
    let isActive: Bool
    let name: String
    let age: Int
    let company: String
    let email: String
    let address: String
    let about: String
    let registered: String // Store as String initially
    let tags: [String]
    let friends: [Friend]
    
    // Computed property to convert registered String to Date
    var registeredDate: Date? {
        let formatter = ISO8601DateFormatter()
        return formatter.date(from: registered)
    }
    
    func hash(into hasher: inout Hasher) {
            hasher.combine(id)
            hasher.combine(isActive)
            hasher.combine(name)
            hasher.combine(age)
            hasher.combine(company)
            hasher.combine(email)
            hasher.combine(address)
            hasher.combine(about)
            hasher.combine(registered)
            hasher.combine(tags)
            hasher.combine(friends)
    }
}

struct Friend : Codable , Hashable {
    let id : String
    let name : String
}
