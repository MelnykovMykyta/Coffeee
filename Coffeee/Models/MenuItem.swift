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

enum Menu: String, CaseIterable{
    case coffee
    case freshcoffee
    case desserts
    case platters
    
    var index: Int {
        switch self {
        case .coffee:
            return 0
        case .freshcoffee:
            return 1
        case .desserts:
            return 2
        case .platters:
            return 3
        }
    }
    
    var desc: String {
        switch self {
        case .coffee:
            return "Напої"
        case .freshcoffee:
            return "Прохолодні напої"
        case .desserts:
            return "Десерти"
        case .platters:
            return "Закуски"
        }
    }
}
