//
//  ActionInfoVC.swift
//  Coffeee
//
//  Created by Nikita Melnikov on 20.03.2024.
//

import Foundation
import UIKit
import SnapKit
import SDWebImage

class ActionInfoVC: UIViewController {
    
    private var image: UIImageView!
    private var startDate: UILabel!
    private var finishDate: UILabel!
    private var desk: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
}

extension ActionInfoVC: ActionDelegate {
    func didSelectAction(_ action: Action) {
        guard let url = URL(string: action.icon) else { return }
        image.sd_setImage(with: url)
        startDate.text = "\(D.Texts.startDate): \(action.startDate)"
        finishDate.text = "\(D.Texts.finishDate): \(action.finishDate)"
        desk.text = action.desc
    }
}

private extension ActionInfoVC {
    
    func setupView() {
        view.backgroundColor = D.Colors.mainBackgroundColor
        
        image = UIImageView()
        image.contentMode = .scaleAspectFit
        view.addSubview(image)
        
        startDate = UILabel()
        startDate.textColor = .black
        startDate.font = UIFont(name: "URWGeometric-SemiBold", size: 28)
        startDate.adjustsFontSizeToFitWidth = true
        startDate.adjustsFontForContentSizeCategory = true
        view.addSubview(startDate)
        
        finishDate = UILabel()
        finishDate.textColor = .black
        finishDate.font = UIFont(name: "URWGeometric-SemiBold", size: 28)
        finishDate.adjustsFontSizeToFitWidth = true
        finishDate.adjustsFontForContentSizeCategory = true
        view.addSubview(finishDate)
        
        let deskLabel = UILabel()
        deskLabel.text = D.Texts.desk
        deskLabel.textColor = .black.withAlphaComponent(0.5)
        deskLabel.font = UIFont(name: "URWGeometric-SemiBold", size: 28)
        deskLabel.adjustsFontSizeToFitWidth = true
        deskLabel.adjustsFontForContentSizeCategory = true
        view.addSubview(deskLabel)
        
        desk = UILabel()
        desk.textColor = .black
        desk.numberOfLines = 0
        desk.textAlignment = .left
        desk.lineBreakMode = .byWordWrapping
        desk.font = UIFont(name: "URWGeometric-Regular", size: 28)
        desk.adjustsFontSizeToFitWidth = true
        desk.adjustsFontForContentSizeCategory = true
        view.addSubview(desk)
        
        image.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(image.snp.width).multipliedBy(0.5)
        }
        
        startDate.snp.makeConstraints {
            $0.top.equalTo(image.snp.bottom).inset(-20)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        finishDate.snp.makeConstraints {
            $0.top.equalTo(startDate.snp.bottom).inset(-10)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        deskLabel.snp.makeConstraints {
            $0.top.equalTo(finishDate.snp.bottom).inset(-20)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        desk.snp.makeConstraints {
            $0.top.equalTo(deskLabel.snp.bottom).inset(-10)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
    }
}
