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
    
    var favoriteRelay = BehaviorRelay<[(key: String, value: [String: Any])]?>(value: nil)
    var favoriteObservable: Observable<[(key: String, value: [String: Any])]> {
        return favoriteRelay.asObservable()
            .compactMap { $0 }
    }
    
    func getFavorite() {
        guard let currentUser = Auth.auth().currentUser else { return }
        
        usersRef.child(currentUser.uid).child("favorite").observeSingleEvent(of: .value) { [weak self] snapshot, _ in
            guard let self = self else { return }
            
            if let favoriteData = snapshot.value as? [String: [String: Any]] {
                let favoritesArray = favoriteData.map { (key: $0.key, value: $0.value) }
                self.favoriteRelay.accept(favoritesArray)
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
                Alert.getDoneAlert(with: D.Texts.addMenuItem)
            }
        }
    }
    
    func removeFavorite(itemKey: String) {
        guard let currentUser = Auth.auth().currentUser else { return }
        
        let favoriteRef = usersRef.child(currentUser.uid).child("favorite").child(itemKey)
        
        favoriteRef.removeValue { error, _ in
            if let error = error {
                print(error.localizedDescription)
            } else {
                self.getFavorite()
            }
        }
    }
}
