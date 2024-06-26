//
//  GuideVC.swift
//  Coffeee
//
//  Created by Nikita Melnikov on 03.03.2024.
//

import Foundation
import UIKit
import OnboardKit

class GuideVC: UIViewController {
    
    private var isFirstLaunch = true
    private let viewModel = AuthViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if isFirstLaunch {
            showOnboardingCustom()
            isFirstLaunch = false
        }
    }
}
private extension GuideVC {
    
    func showOnboardingCustom() {
        
        var boldTitleFont = UIFont.systemFont(ofSize: 32.0, weight: .bold)
        var mediumTextFont = UIFont.systemFont(ofSize: 17.0, weight: .semibold)
        
        if let boldTitleFont_ = UIFont(name: "URWGeometric-SemiBold", size: 32),
           let mediumTextFont_ = UIFont(name: "URWGeometric-Regular", size: 17) {
            boldTitleFont = boldTitleFont_
            mediumTextFont = mediumTextFont_
        }
        
        let appearanceConfiguration = OnboardViewController
            .AppearanceConfiguration(tintColor: D.Colors.nameColor,
                                     titleColor: D.Colors.nameColor,
                                     textColor: D.Colors.nameColor,
                                     backgroundColor: D.Colors.mainBackgroundColor,
                                     titleFont: boldTitleFont,
                                     textFont: mediumTextFont)
        let onboardingVC = OnboardViewController(pageItems: [Onboard.firstPage.page, Onboard.secondPage.page, Onboard.thirdPage.page], appearanceConfiguration: appearanceConfiguration) {
            self.viewModel.checkAuthentication()
        }
        onboardingVC.modalPresentationStyle = .fullScreen
        onboardingVC.presentFrom(self, animated: true)
    }
}
