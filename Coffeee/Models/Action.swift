//
//  Action.swift
//  Coffeee
//
//  Created by Nikita Melnikov on 19.03.2024.
//

import Foundation

struct Action: Codable {
    let name: String
    let startDate: String
    let finishDate: String
    let desc: String
    let icon: String
    
    static func parse(from data: [String: Any]) -> Action? {
        guard let name = data["name"] as? String,
              let startDate = data["startDate"] as? String,
              let finishDate = data["finishDate"] as? String,
              let desc = data["desc"] as? String,
              let icon = data["icon"] as? String else {
            return nil
        }
        
        return Action(name: name, startDate: startDate, finishDate: finishDate, desc: desc, icon: icon)
    }
}
