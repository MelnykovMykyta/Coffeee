//
//  D.swift
//  Coffeee
//
//  Created by Nikita Melnikov on 03.03.2024.
//

import Foundation
import UIKit

struct D {
    
    struct Colors {
        static let mainBackgroundColor =        UIColor.white
        static let standartTextColor =          UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        static let standartTextWithAlpha =      UIColor(red: 1, green: 1, blue: 1, alpha: 0.5)
        static let nameColor =                  UIColor(red: 8/255, green: 137/255, blue: 193/255, alpha: 1)
    }
    
    struct Texts {
        static let animation = "Coffeee"
    }
    
    struct Onboard {
        static let nextButton = "Далі"
        static let doneButton = "Почати"
        static let firstPageTitle = "Вітаємо в Coffeee"
        static let firstPageDesc = "Формуй замовлення прямо тут і покажи на касі лише QR-код"
        static let secondPageTitle = "Система накопичення"
        static let secondPageDesc = "Пий каву - прокачуй свою знижку"
        static let thirdPageTitle = "Акції"
        static let thirdPageDesc = "Будь в курсі крутих акцій"
    }
}
