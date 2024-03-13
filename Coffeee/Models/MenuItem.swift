//
//  MenuItem.swift
//  Coffeee
//
//  Created by Nikita Melnikov on 10.03.2024.
//

import Foundation

struct MenuItem: Codable {
    let name, ingredients: String
    let price: Int
    let icon: String
}

enum Menu: String {
    case coffee, refreshers, breakfast, platters
}
