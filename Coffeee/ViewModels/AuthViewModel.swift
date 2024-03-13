//
//  AuthViewModel.swift
//  Coffeee
//
//  Created by Nikita Melnikov on 08.03.2024.
//

import Foundation
import FirebaseAuth

class AuthViewModel {
    
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
            VCChanger.changeVC(vc: NavTabBarController())
        }
    }
    
    static func checkAuthentication() {
        guard Auth.auth().currentUser != nil else {
            VCChanger.changeVC(vc: PhoneAuthVC())
            return
        }
        VCChanger.changeVC(vc: NavTabBarController())
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
}
