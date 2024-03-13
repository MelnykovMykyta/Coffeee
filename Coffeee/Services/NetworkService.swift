//
//  NetworkService.swift
//  Coffeee
//
//  Created by Nikita Melnikov on 10.03.2024.
//

import Foundation
import FirebaseCore
import FirebaseDatabase

class NetworkService {
    
    static func getMenu(with items: Menu, completion: @escaping ([MenuItem]?) -> Void) {
        let ref = Database.database().reference()
        
        ref.child(items.rawValue).observeSingleEvent(of: .value, with: { snapshot in
            guard let value = snapshot.value, let data = try? JSONSerialization.data(withJSONObject: value) else {
                completion(nil)
                return
            }
            
            do {
                let items = try JSONDecoder().decode([MenuItem].self, from: data)
                completion(items)
            } catch {
                completion(nil)
            }
        })
    }
}
