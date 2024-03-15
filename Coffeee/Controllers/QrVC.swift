//
//  QrVC.swift
//  Coffeee
//
//  Created by Nikita Melnikov on 03.03.2024.
//

import Foundation
import UIKit
import SnapKit
import FirebaseAuth
import SimpleQRCode

class QrVC: UIViewController {
    
    private var qrImage: UIImageView!
    private var cupFrame: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
        if let user = Auth.auth().currentUser,
           var qrCode = QRCode(string: user.uid) {
            qrCode.size = CGSize(width: 300, height: 300)
            qrCode.scale = 1.0
            qrCode.inputCorrection = .quartile
            qrImage.image = try? qrCode.image()
        }
    }
}

private extension QrVC {
    
    func setupView() {
        view.backgroundColor = D.Colors.mainBackgroundColor
        
        cupFrame = UIImageView()
        cupFrame.image = UIImage(named: "cupFrameQR")
        view.addSubview(cupFrame)
        
        qrImage = UIImageView()
        view.addSubview(qrImage)
        
        let topLabel = UILabel()
        topLabel.text = D.Texts.topQr
        topLabel.font = UIFont(name: "URWGeometric-SemiBold", size: 80)
        topLabel.adjustsFontSizeToFitWidth = true
        topLabel.numberOfLines = 2
        topLabel.textColor = D.Colors.nameColor
        topLabel.textAlignment = .center
        view.addSubview(topLabel)
        
        cupFrame.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(cupFrame.snp.width).multipliedBy(1.5)
        }
        
        qrImage.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.equalTo(cupFrame.snp.width).multipliedBy(0.4)
            $0.height.equalTo(qrImage.snp.width)
        }
        
        topLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(40)
            $0.leading.trailing.equalToSuperview().inset(40)
            $0.bottom.equalTo(cupFrame.snp.top).inset(40)
        }
    }
}
