//
//  ActionItemTVC.swift
//  Coffeee
//
//  Created by Nikita Melnikov on 19.03.2024.
//

import Foundation
import UIKit
import SnapKit

class ActionItemTVC: UITableViewCell {
    
    private var view: UIView!
    var image: UIImageView!
    private var nameView: UIView!
    var nameLabel: UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        view.layer.cornerRadius = 20
        view.layer.masksToBounds = true
        view.layer.shadowOffset = CGSize(width: 0, height: 3)
        view.layer.shadowRadius = 8
        view.layer.shadowOpacity = 0.1
        view.layer.shadowColor = UIColor.gray.cgColor
        view.layer.shadowPath = UIBezierPath(roundedRect: view.bounds, byRoundingCorners: .allCorners, cornerRadii: CGSize(width: 20, height: 20)).cgPath
        view.layer.shouldRasterize = true
        view.layer.rasterizationScale = UIScreen.main.scale
    }
}

private extension ActionItemTVC {
    
    func setupView() {
        backgroundColor = .clear
        selectionStyle = .none
        
        view = UIView()
        view.backgroundColor = D.Colors.mainBackgroundColor
        addSubview(view)
        
        image = UIImageView()
        image.contentMode = .scaleAspectFit
        view.addSubview(image)
        
        nameView = UIView()
        nameView.backgroundColor = D.Colors.nameColor
        nameView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        view.addSubview(nameView)
        
        nameLabel = UILabel()
        nameLabel.font = UIFont(name: "URWGeometric-SemiBold", size: 14)
        nameLabel.numberOfLines = 1
        nameLabel.textColor = D.Colors.standartTextColor
        nameLabel.textAlignment = .center
        nameView.addSubview(nameLabel)
    
        view.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(10)
            $0.height.equalTo(view.snp.width).multipliedBy(0.5)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        image.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        nameView.snp.makeConstraints {
            $0.height.equalToSuperview().multipliedBy(0.2)
            $0.bottom.leading.trailing.equalToSuperview()
        }
        
        nameLabel.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(20)
        }
    }
}
