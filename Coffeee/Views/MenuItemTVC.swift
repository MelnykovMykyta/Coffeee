//
//  MenuItemTVC.swift
//  Coffeee
//
//  Created by Nikita Melnikov on 12.03.2024.
//

import Foundation
import UIKit
import SnapKit

class MenuItemTVC: UITableViewCell {
    
    private var view: UIView!
    var image: UIImageView!
    var nameLabel: UILabel!
    var descLabel: UILabel!
    var priceLabel: UILabel!
    var priceNameLabel: UILabel!
    var currencyLabel: UILabel!
    
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
        view.layer.shadowOffset = CGSize(width: 0, height: 3)
        view.layer.shadowRadius = 8
        view.layer.shadowOpacity = 0.1
        view.layer.shadowColor = UIColor.gray.cgColor
        view.layer.shadowPath = UIBezierPath(roundedRect: view.bounds, byRoundingCorners: .allCorners, cornerRadii: CGSize(width: 20, height: 20)).cgPath
        view.layer.shouldRasterize = true
        view.layer.rasterizationScale = UIScreen.main.scale
    }
}

private extension MenuItemTVC {
    
    func setupView() {
        backgroundColor = .clear
        selectionStyle = .none
        
        view = UIView()
        view.backgroundColor = D.Colors.mainBackgroundColor
        addSubview(view)
        
        nameLabel = UILabel()
        nameLabel.font = UIFont(name: "URWGeometric-SemiBold", size: 24)
        nameLabel.numberOfLines = 0
        nameLabel.textColor = .black
        nameLabel.textAlignment = .left
        view.addSubview(nameLabel)
        
        descLabel = UILabel()
        descLabel.font = UIFont(name: "URWGeometric-Regular", size: 14)
        descLabel.textColor = .black.withAlphaComponent(0.5)
        descLabel.textAlignment = .left
        descLabel.numberOfLines = 0
        view.addSubview(descLabel)
        
        priceNameLabel = UILabel()
        priceNameLabel.text = "Ціна"
        priceNameLabel.font = UIFont(name: "URWGeometric-SemiBold", size: 12)
        priceNameLabel.textColor = D.Colors.darkGreen
        priceNameLabel.textAlignment = .left
        view.addSubview(priceNameLabel)
        
        currencyLabel = UILabel()
        currencyLabel.text = "₴"
        currencyLabel.font = UIFont(name: "URWGeometric-SemiBold", size: 14)
        currencyLabel.textColor = .black
        currencyLabel.textAlignment = .left
        view.addSubview(currencyLabel)
        
        priceLabel = UILabel()
        priceLabel.font = UIFont(name: "URWGeometric-SemiBold", size: 24)
        priceLabel.textColor = .black
        priceLabel.textAlignment = .left
        view.addSubview(priceLabel)
        
        image = UIImageView()
        image.contentMode = .scaleAspectFit
        view.addSubview(image)
        
        view.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(10)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        nameLabel.snp.makeConstraints {
            $0.width.equalTo(view.snp.width).multipliedBy(0.6)
            $0.top.leading.equalToSuperview().inset(20)
        }
        
        descLabel.snp.makeConstraints {
            $0.width.equalTo(view.snp.width).multipliedBy(0.6)
            $0.top.equalTo(nameLabel.snp.bottom).inset(-8)
            $0.leading.equalToSuperview().inset(20)
        }
        
        priceNameLabel.snp.makeConstraints {
            $0.top.equalTo(descLabel.snp.bottom).inset(-20)
            $0.leading.equalToSuperview().inset(20)
        }
        
        currencyLabel.snp.makeConstraints {
            $0.top.equalTo(priceNameLabel.snp.bottom).inset(-8)
            $0.leading.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview().inset(20)
        }
        
        priceLabel.snp.makeConstraints {
            $0.top.equalTo(currencyLabel.snp.top)
            $0.leading.equalTo(currencyLabel.snp.trailing)
            $0.width.equalTo(view.snp.width).multipliedBy(0.4)
            $0.bottom.equalToSuperview().inset(20)
        }
        
        image.snp.makeConstraints {
            $0.top.trailing.bottom.equalToSuperview()
            $0.leading.equalTo(nameLabel.snp.trailing)
        }
    }
}
