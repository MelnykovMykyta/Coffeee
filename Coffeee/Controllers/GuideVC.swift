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
        let boldTitleFont = UIFont.systemFont(ofSize: 32.0, weight: .bold)
        let mediumTextFont = UIFont.systemFont(ofSize: 17.0, weight: .semibold)
        let appearanceConfiguration = OnboardViewController
            .AppearanceConfiguration(tintColor: D.Colors.nameColor,
                                     titleColor: D.Colors.nameColor,
                                     textColor: D.Colors.nameColor,
                                     backgroundColor: D.Colors.mainBackgroundColor,
                                     titleFont: boldTitleFont,
                                     textFont: mediumTextFont)
        let onboardingVC = OnboardViewController(pageItems: [Onboard.firstPage.page, Onboard.secondPage.page, Onboard.thirdPage.page],
                                                 appearanceConfiguration: appearanceConfiguration) {
            AuthViewModel.checkAuthentication()
        }
        onboardingVC.modalPresentationStyle = .fullScreen
        onboardingVC.presentFrom(self, animated: true)
    }
}
