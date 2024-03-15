//
//  MainVC.swift
//  Coffeee
//
//  Created by Nikita Melnikov on 03.03.2024.
//

import Foundation
import UIKit
import SnapKit
import RxSwift
import RxCocoa

class MainVC: UIViewController {
    
    private let viewModel = AuthViewModel()
    private var user: User?
    private var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
        viewModel.userObservable
            .subscribe(onNext: { [weak self] user in
                self?.user = user
            }).disposed(by: disposeBag)
        
        viewModel.getUser()
    }
    
    @objc func tap() {
        viewModel.signOut()
        VCChanger.changeVC(vc: PhoneAuthVC())
    }
}

private extension MainVC {
    
    func setupView() {
        view.backgroundColor = .blue
        
        let signOut = UIButton(type: .system)
        signOut.setTitle("Вихід", for: .normal)
        signOut.addTarget(self, action: #selector(tap), for: .touchUpInside)
        view.addSubview(signOut)
        
        signOut.snp.makeConstraints { $0.center.equalToSuperview() }
    }
}
