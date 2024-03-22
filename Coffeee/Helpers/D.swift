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
        static let darkGreen =                  UIColor(red: 60.0/255.0, green: 230.0/255.0, blue: 0.0, alpha: 1.0)
    }
    
    struct Texts {
        static let animation = "Coffeee"
        static let enterPhone = "Пройди верифікацію"
        static let fillNumber = "Введи свій номер телефону"
        static let authPhoneBtn = "Надіслати код"
        static let fillCode = "Введи отриманий код"
        static let verify = "Підтвердити"
        static let backButton = "Повернутись назад?"
        static let enterName = "Введи ім'я"
        static let fillName = "Як до тебе звертатись?"
        static let namePlaceholder = "Твоє ім'я"
        static let menuLabel = "Меню"
        static let topQr = "Скануй QR та накопичуй знижку"
        static let favoriteLabel = "Улюблений набір"
        static let addMenuItem = "Додано до твого набору"
        static let actions = "Акції та пропозиції"
        static let discount = "Твоя знижка"
        static let startDate = "Початок"
        static let finishDate = "Кінець"
        static let desk = "Опис"
    }
    
    struct Onboard {
        static let nextButton = "Далі"
        static let doneButton = "Почати"
        static let firstPageTitle = "Вітаємо в Coffeee"
        static let firstPageDesc = "Додавай в улюблене і на касі показуй лише QR-код"
        static let secondPageTitle = "Система накопичення"
        static let secondPageDesc = "Пий каву - прокачуй свою знижку"
        static let thirdPageTitle = "Акції"
        static let thirdPageDesc = "Будь в курсі крутих акцій"
    }
}
