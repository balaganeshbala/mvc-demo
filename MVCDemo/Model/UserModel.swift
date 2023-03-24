//
//  UserModel.swift
//  MVCDemo
//
//  Created by Balaganesh on 23/03/23.
//

import Foundation

struct User: Codable {
    let id: Int
    let name, email, phone: String
    let address: Address
}

struct Address: Codable {
    let street, suite, city, zipcode: String
}
