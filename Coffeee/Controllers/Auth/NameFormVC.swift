//
//  NameFormVC.swift
//  Coffeee
//
//  Created by Nikita Melnikov on 22.03.2024.
//

import Foundation
import UIKit
import SnapKit
import RxSwift
import RxCocoa

class NameFormVC: UIViewController {
    
    private let viewModel = AuthViewModel()
    private let disposeBag = DisposeBag()
    
    private var contentView: UIView!
    private var nameTF: UITextField!
    private var button: UIButton!
    private var backButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        addKeyboardDismissGesture()
        
        nameTF.rx.text.orEmpty
            .map { !$0.isEmpty }
            .bind(to: button.rx.isEnabled)
            .disposed(by: disposeBag)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        button.layer.cornerRadius = button.frame.height / 4
        contentView.layer.cornerRadius = 20
        contentView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
    @objc private func createUser() {
        guard let name = nameTF.text else { return }
        viewModel.createUser(name: name)
    }
    
    @objc private func back() {
        VCChanger.changeVCWithoutDuration(vc: PhoneAuthVC())
    }
}

extension NameFormVC {
    private func setupView() {
        
        view.backgroundColor = D.Colors.nameColor
        
        contentView = UIView()
        contentView.backgroundColor = D.Colors.mainBackgroundColor
        view.addSubview(contentView)
        
        let image = UIImageView()
        image.image = UIImage(named: "cup")
        image.tintColor = D.Colors.mainBackgroundColor
        image.contentMode = .scaleAspectFit
        view.addSubview(image)
        
        let sv = UIStackView()
        sv.axis = .vertical
        sv.spacing = 20
        sv.distribution = .fill
        view.addSubview(sv)
        
        let label = UILabel()
        label.text = D.Texts.enterName
        label.font = UIFont(name: "URWGeometric-SemiBold", size: 40)
        label.adjustsFontSizeToFitWidth = true
        label.textColor = D.Colors.standartTextColor
        label.textAlignment = .left
        label.numberOfLines = 2
        view.addSubview(label)
        
        let guideLabel = UILabel()
        guideLabel.text = D.Texts.fillName
        guideLabel.font = UIFont(name: "URWGeometric-Regular", size: 20)
        guideLabel.adjustsFontSizeToFitWidth = true
        guideLabel.textColor = .black
        guideLabel.numberOfLines = 2
        guideLabel.textAlignment = .center
        sv.addArrangedSubview(guideLabel)
        
        nameTF = UITextField()
        nameTF.placeholder = D.Texts.namePlaceholder
        nameTF.textAlignment = .center
        nameTF.font = .boldSystemFont(ofSize: 28)
        sv.addArrangedSubview(nameTF)
        
        button = UIButton(type: .system)
        if let font = UIFont(name: "URWGeometric-Regular", size: 20) {
            button.titleLabel?.font = font
        }
        button.backgroundColor = D.Colors.mainBackgroundColor
        button.tintColor = D.Colors.nameColor
        button.setTitle(D.Texts.verify, for: .normal)
        button.isEnabled = false
        button.addTarget(self, action: #selector(createUser), for: .touchUpInside)
        sv.addArrangedSubview(button)
        
        backButton = UIButton(type: .system)
        backButton.setTitle(D.Texts.backButton, for: .normal)
        backButton.addTarget(self, action: #selector(back), for: .touchUpInside)
        view.addSubview(backButton)
        
        sv.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(40)
        }
        
        contentView.snp.makeConstraints {
            $0.top.equalTo(sv.snp.top).inset(-80)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        label.snp.makeConstraints {
            $0.top.leading.equalToSuperview().inset(20)
            $0.width.equalTo(sv.snp.width)
            $0.bottom.equalTo(contentView.snp.top).inset(-20)
        }
        
        image.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(0.25)
            $0.height.equalTo(image.snp.width)
            $0.trailing.equalToSuperview().inset(20)
            $0.bottom.equalTo(contentView.snp.top)
        }
        
        nameTF.snp.makeConstraints {
            $0.height.equalTo(80)
            $0.width.equalTo(sv.snp.width)
        }
        
        button.snp.makeConstraints {
            $0.height.equalTo(40)
            $0.width.equalTo(sv.snp.width)
        }
        
        backButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(20)
        }
    }
}
