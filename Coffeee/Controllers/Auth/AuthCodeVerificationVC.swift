//
//  AuthCodeVerificationVC.swift
//  Coffeee
//
//  Created by Nikita Melnikov on 06.03.2024.
//

import Foundation
import UIKit
import SnapKit
import DPOTPView

class AuthCodeVerificationVC: UIViewController {
    
    private let viewModel = AuthViewModel()
    
    private var contentView: UIView!
    private var codeTF: DPOTPView!
    private var button: UIButton!
    private var backButton: UIButton!
    
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

extension AuthCodeVerificationVC : DPOTPViewDelegate {
    
    @objc private func signIn() {
        guard let code = codeTF.text else { return }
        viewModel.signIn(code: code)
    }
    
    func dpOTPViewAddText(_ text: String, at position: Int) {
        button.isEnabled = codeTF.validate()
    }
    
    @objc override func dismissKeyboardTouchOutside() {
        view.endEditing(true)
        codeTF.resignFirstResponder()
    }
    
    @objc private func back() {
        VCChanger.changeVCWithoutDuration(vc: PhoneAuthVC())
    }
    
    func dpOTPViewBecomeFirstResponder() {}
    func dpOTPViewResignFirstResponder() {}
    func dpOTPViewRemoveText(_ text: String, at position: Int) {}
    func dpOTPViewChangePositionAt(_ position: Int) {}
}

extension AuthCodeVerificationVC {
    
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
        label.font = UIFont(name: "URWGeometric-SemiBold", size: 40)
        label.adjustsFontSizeToFitWidth = true
        label.textColor = D.Colors.standartTextColor
        label.textAlignment = .left
        label.numberOfLines = 2
        view.addSubview(label)
        
        let guideLabel = UILabel()
        guideLabel.text = D.Texts.fillCode
        guideLabel.font = UIFont(name: "URWGeometric-Regular", size: 20)
        guideLabel.adjustsFontSizeToFitWidth = true
        guideLabel.textColor = .black
        guideLabel.numberOfLines = 0
        guideLabel.textAlignment = .center
        sv.addArrangedSubview(guideLabel)
        
        codeTF = DPOTPView()
        codeTF.count = 6
        codeTF.spacing = 8
        codeTF.fontTextField = .systemFont(ofSize: 28)
        codeTF.dismissOnLastEntry = true
        codeTF.borderColorTextField = .lightGray
        codeTF.selectedBorderColorTextField = .lightGray
        codeTF.borderWidthTextField = 2
        codeTF.backGroundColorTextField = .clear
        codeTF.cornerRadiusTextField = 8
        codeTF.isCursorHidden = false
        codeTF.isBottomLineTextField = true
        codeTF.dpOTPViewDelegate = self
        codeTF.becomeFirstResponder()
        sv.addArrangedSubview(codeTF)
        
        button = UIButton(type: .system)
        button.backgroundColor = D.Colors.mainBackgroundColor
        button.layer.borderWidth = 1
        button.layer.borderColor = D.Colors.nameColor.cgColor
        button.tintColor = D.Colors.nameColor
        button.setTitle(D.Texts.verify, for: .normal)
        button.isEnabled = false
        button.addTarget(self, action: #selector(signIn), for: .touchUpInside)
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
        
        codeTF.snp.makeConstraints {
            $0.height.equalTo(80)
            $0.width.equalTo(sv.snp.width)
        }
        
        button.snp.makeConstraints {
            $0.height.equalTo(40)
            $0.width.equalTo(sv.snp.width)
        }
        
        backButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(sv.snp.bottom).inset(-80)
        }
    }
}
