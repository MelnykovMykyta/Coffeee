//
//  Onboard.swift
//  Coffeee
//
//  Created by Nikita Melnikov on 03.03.2024.
//

import Foundation
import UIKit
import OnboardKit

enum Onboard {
    
    case firstPage
    case secondPage
    case thirdPage
    
    var page: OnboardPage {
        
        switch self {
        case .firstPage:
            return OnboardPage(title: D.Onboard.firstPageTitle, imageName: "favoriteOnboard", description: D.Onboard.firstPageDesc, advanceButtonTitle: D.Onboard.nextButton)
        case .secondPage:
            return OnboardPage(title: D.Onboard.secondPageTitle, imageName: "progressOnboard", description: D.Onboard.secondPageDesc, advanceButtonTitle: D.Onboard.nextButton)
        case .thirdPage:
            return OnboardPage(title: D.Onboard.thirdPageTitle, imageName: "actionOnboard", description: D.Onboard.thirdPageDesc, advanceButtonTitle: D.Onboard.doneButton)
        }
    }
}
