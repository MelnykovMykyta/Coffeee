//
//  AuthViewModel.swift
//  Coffeee
//
//  Created by Nikita Melnikov on 08.03.2024.
//

import Foundation
import FirebaseAuth
import FirebaseDatabase
import RxSwift
import RxCocoa

class AuthViewModel {
    
    private let usersRef = Database.database().reference().child("users")
    
    var userRelay = BehaviorRelay<User?>(value: nil)
    var userObservable: Observable<User?> {
        return userRelay.asObservable()
    }
    
    func verifyNumber(phoneNumber: String) {
        PhoneAuthProvider.provider()
            .verifyPhoneNumber(phoneNumber, uiDelegate: nil) { verificationID, error in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                UserDefaults.standard.set(verificationID, forKey: "authVerificationID")
                VCChanger.changeVCWithoutDuration(vc: AuthCodeVerificationVC())
            }
    }
    
    func signIn(code: String) {
        guard let currentVerificationId = UserDefaults.standard.string(forKey: "authVerificationID") else { return }
        
        let credential = PhoneAuthProvider.provider().credential(withVerificationID: currentVerificationId, verificationCode: code)
        
        Auth.auth().signIn(with: credential) { (authResult, error) in
            if let error = error {
                let authError = error as NSError
                print(authError.description)
                return
            }
            
            self.checkUser()
        }
    }
    
    func checkAuthentication() {
        guard Auth.auth().currentUser != nil else {
            VCChanger.changeVC(vc: PhoneAuthVC())
            return
        }
        
        self.checkUser()
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
    
    func checkUser() {
        guard let currentUser = Auth.auth().currentUser else { return }
        
        usersRef.child(currentUser.uid).observeSingleEvent(of: .value) { [weak self] (snapshot) in
            guard let self = self else { return }
            
            if snapshot.exists() {
                VCChanger.changeVC(vc: NavTabBarController())
            } else {
                
                guard let viewController = UIApplication.shared.windows.first?.rootViewController else { return }
                
                let alert = UIAlertController(title: D.Texts.enterName, message: nil, preferredStyle: .alert)
                alert.addTextField { textField in
                    textField.placeholder = D.Texts.namePlaceholder
                }
                
                alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
                    guard let name = alert.textFields?.first?.text else { return }
                    
                    let phoneNumber = currentUser.phoneNumber ?? ""
                    self.createUser(user: User(id: currentUser.uid, name: name, phone: phoneNumber, discount: 10, cupsCount: 0))
                })
                viewController.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    func createUser(user: User) {
        usersRef.child(user.id).setValue([
            "id": user.id,
            "name": user.name,
            "phone": user.phone,
            "discount": user.discount,
            "cupsCount": user.cupsCount
        ]) { (error, _) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                VCChanger.changeVC(vc: NavTabBarController())
            }
        }
    }
    
    func getUser() {
        guard let currentUser = Auth.auth().currentUser else { return }
        
        usersRef.child(currentUser.uid).observeSingleEvent(of: .value) { [weak self] (snapshot) in
            guard let userData = snapshot.value as? [String: Any],
                  snapshot.exists(),
                  let self = self else { return }
            
            let userFromDatabase = User(id: userData["id"] as? String ?? "",
                                        name: userData["name"] as? String ?? "",
                                        phone: userData["phone"] as? String ?? "",
                                        discount: userData["discount"] as? Int ?? 0,
                                        cupsCount: userData["cupsCount"] as? Int ?? 0)
            self.userRelay.accept(userFromDatabase)
        }
    }
}
