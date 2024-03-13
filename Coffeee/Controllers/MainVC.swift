//
//  MainVC.swift
//  Coffeee
//
//  Created by Nikita Melnikov on 03.03.2024.
//

import Foundation
import UIKit
import SnapKit

class MainVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        
        let signOut = UIButton(type: .system)
        signOut.setTitle("Вихід", for: .normal)
        signOut.addTarget(self, action: #selector(tap), for: .touchUpInside)
        view.addSubview(signOut)
        
        signOut.snp.makeConstraints { $0.center.equalToSuperview() }
    }
    
    @objc func tap() {
        AuthViewModel().signOut()
        VCChanger.changeVC(vc: PhoneAuthVC())
    }
}
