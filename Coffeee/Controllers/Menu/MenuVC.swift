//
//  MenuVC.swift
//  Coffeee
//
//  Created by Nikita Melnikov on 14.03.2024.
//

import Foundation
import UIKit
import SnapKit
import TabsPager

class MenuVC: UIViewController {
    
    private var tabsPager: TabsPager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setControllers()
    }
}

private extension MenuVC {
    
    func setupView() {
        view.backgroundColor = D.Colors.mainBackgroundColor
        
        let label = UILabel()
        label.text = D.Texts.menuLabel
        label.font =  UIFont(name: "URWGeometric-SemiBold", size: 28)
        view.addSubview(label)
        
        tabsPager = TabsPager()
        tabsPager.tabColor = D.Colors.mainBackgroundColor
        tabsPager.tabLineColor = D.Colors.standartTextWithAlpha
        tabsPager.backgroundColor = D.Colors.mainBackgroundColor
        tabsPager.tabTitleColor = .black.withAlphaComponent(0.5)
        tabsPager.tabSelectedTitleColor = .black
        tabsPager.sliderColor = .black.withAlphaComponent(0.5)
        
        if let font = UIFont(name: "URWGeometric-SemiBold", size: 18) {
            tabsPager.tabTextFont = font
        } else {
            tabsPager.tabTextFont = .systemFont(ofSize: 18)
        }
        
        self.addChild(tabsPager)
        view.addSubview(tabsPager.view)
        
        label.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(20)
            $0.centerX.equalToSuperview()
        }
        
        tabsPager.view.snp.makeConstraints {
            $0.top.equalTo(label.snp.bottom).inset(-20)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    func setControllers() {
        var vcs: [TabsPagerContentVC] = []
        
        Menu.allCases.forEach { value in
            let vc = MenuSectionVC()
            vc.pageIndex = value.index
            vc.tabTitle = value.desc
            vcs.append(vc)
        }
        
        tabsPager.contentVCs = vcs
    }
}
