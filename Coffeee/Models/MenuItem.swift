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
    
    static func parse(from data: [String: Any]) -> MenuItem? {
        guard let name = data["name"] as? String,
              let ingredients = data["ingredients"] as? String,
              let price = data["price"] as? Int,
              let icon = data["icon"] as? String else {
            return nil
        }
        
        return MenuItem(name: name, ingredients: ingredients, price: price, icon: icon)
    }
    
    func toDictionary() -> [String: Any] {
        return [
            "name": name,
            "ingredients": ingredients,
            "price": price,
            "icon": icon
        ]
    }
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
