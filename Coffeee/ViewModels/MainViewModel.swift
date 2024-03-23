//
//  MainViewModel.swift
//  Coffeee
//
//  Created by Nikita Melnikov on 19.03.2024.
//

import Foundation
import FirebaseAuth
import FirebaseCore
import FirebaseDatabase

class MainViewModel {
    
    private let ref = Database.database().reference()
    
    func getActions(completion: @escaping ([Action]?) -> Void) {
        ref.child("actions").observeSingleEvent(of: .value) { snapshot in
            guard let actionsData = snapshot.value as? [[String: Any]] else {
                completion(nil)
                return
            }
            
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: actionsData)
                let actions = try JSONDecoder().decode([Action].self, from: jsonData)
                completion(actions)
            } catch {
                completion(nil)
            }
        }
    }
}
