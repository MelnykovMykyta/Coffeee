//
//  NetworkService.swift
//  Coffeee
//
//  Created by Nikita Melnikov on 10.03.2024.
//

import Foundation
import FirebaseAuth
import FirebaseCore
import FirebaseDatabase
import RxSwift
import RxCocoa

class NetworkService {
    
    private let ref = Database.database().reference()
    
    func getMenu(with items: Menu, completion: @escaping ([MenuItem]?) -> Void) {
        ref.child(items.rawValue).observeSingleEvent(of: .value) { snapshot in
            guard let value = snapshot.value,
                  let data = try? JSONSerialization.data(withJSONObject: value) else {
                completion(nil)
                return
            }
            
            do {
                let items = try JSONDecoder().decode([MenuItem].self, from: data)
                completion(items)
            } catch {
                completion(nil)
            }
        }
    }
}
