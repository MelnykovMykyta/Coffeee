//
//  PhoneAuthVC.swift
//  Coffeee
//
//  Created by Nikita Melnikov on 06.03.2024.
//

import Foundation
import UIKit
import SnapKit
import FlagPhoneNumber

class PhoneAuthVC: UIViewController {
    
    private let viewModel = AuthViewModel()
    
    private var contentView: UIView!
    private var phoneTF: FPNTextField!
    private var button: UIButton!
    private var phoneNumber: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        addKeyboardDismissGesture()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        button.layer.cornerRadius = button.frame.height / 4
        contentView.layer.cornerRadius = 20
        contentView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
}

extension PhoneAuthVC: FPNTextFieldDelegate {
    
    func fpnDidValidatePhoneNumber(textField: FPNTextField, isValid: Bool) {
        if isValid {
            guard let number = phoneTF.getFormattedPhoneNumber(format: .E164) else { return }
            phoneTF.resignFirstResponder()
            phoneNumber = number
            button.isEnabled = true
        } else {
            button.isEnabled = false
        }
    }
    
    @objc private func sendCode() {
        viewModel.verifyNumber(phoneNumber: phoneNumber)
    }
    
    func fpnDisplayCountryList() {}
    func fpnDidSelectCountry(name: String, dialCode: String, code: String) {}
}

extension PhoneAuthVC {
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
        label.text = D.Texts.enterPhone
        label.font = UIFont(name: "Impact", size: 40)
        label.adjustsFontSizeToFitWidth = true
        label.textColor = D.Colors.standartTextColor
        label.textAlignment = .left
        label.numberOfLines = 2
        view.addSubview(label)
        
        let guideLabel = UILabel()
        guideLabel.text = D.Texts.fillNumber
        guideLabel.font = .systemFont(ofSize: 20)
        guideLabel.adjustsFontSizeToFitWidth = true
        guideLabel.textColor = .black
        guideLabel.numberOfLines = 2
        guideLabel.textAlignment = .center
        sv.addArrangedSubview(guideLabel)
        
        phoneTF = FPNTextField()
        phoneTF.setFlag(key: .UA)
        phoneTF.font = .boldSystemFont(ofSize: 28)
        phoneTF.delegate = self
        sv.addArrangedSubview(phoneTF)
        
        button = UIButton(type: .system)
        button.backgroundColor = D.Colors.mainBackgroundColor
        button.layer.borderWidth = 1
        button.layer.borderColor = D.Colors.nameColor.cgColor
        button.tintColor = D.Colors.nameColor
        button.setTitle(D.Texts.authPhoneBtn, for: .normal)
        button.isEnabled = false
        button.addTarget(self, action: #selector(sendCode), for: .touchUpInside)
        sv.addArrangedSubview(button)
        
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
        
        phoneTF.snp.makeConstraints {
            $0.height.equalTo(80)
            $0.width.equalTo(sv.snp.width)
        }
        
        button.snp.makeConstraints {
            $0.height.equalTo(40)
            $0.width.equalTo(sv.snp.width)
        }
    }
}
