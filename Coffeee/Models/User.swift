//
//  User.swift
//  Coffeee
//
//  Created by Nikita Melnikov on 14.03.2024.
//

import Foundation

class User {
    var id: String
    var name: String
    var phone: String
    var discount: Int
    var cupsCount: Int
    
    init(id: String, name: String, phone: String, discount: Int, cupsCount: Int) {
        self.id = id
        self.name = name
        self.phone = phone
        self.discount = discount
        self.cupsCount = cupsCount
    }
}
