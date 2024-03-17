//
//  FavoriteViewModel.swift
//  Coffeee
//
//  Created by Nikita Melnikov on 17.03.2024.
//

import Foundation
import FirebaseAuth
import FirebaseCore
import FirebaseDatabase
import RxSwift
import RxCocoa

class FavoriteViewModel {
    
    private let usersRef = Database.database().reference().child("users")
    
    var favoriteRelay = BehaviorRelay<[MenuItem?]>(value: [])
    var favoriteObservable: Observable<[MenuItem?]> {
        return favoriteRelay.asObservable()
    }
    
    func getFavorite() {
        guard let currentUser = Auth.auth().currentUser else { return }
        
        usersRef.child(currentUser.uid).child("favorite").observeSingleEvent(of: .value) { [weak self] snapshot in
            guard let self = self else { return }
            
            if let favoriteData = snapshot.value as? [String: [String: Any]] {
                let favorites: [MenuItem] = favoriteData.compactMap { (_, value) in
                    return MenuItem.parse(from: value)
                }
                self.favoriteRelay.accept(favorites)
            } else {
                self.favoriteRelay.accept([])
            }
        }
    }
    
    func addFavorite(item: MenuItem) {
        guard let currentUser = Auth.auth().currentUser else { return }
        
        let newFavoriteRef = usersRef.child(currentUser.uid).child("favorite").childByAutoId()
        let itemDictionary = item.toDictionary()
        
        newFavoriteRef.setValue(itemDictionary) { error, _ in
            if let error = error {
                print(error.localizedDescription)
            } else {
                self.getFavorite()
            }
        }
    }
}
