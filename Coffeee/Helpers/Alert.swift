//
//  Alert.swift
//  Coffeee
//
//  Created by Nikita Melnikov on 17.03.2024.
//

import Foundation
import UIKit
import StatusAlert

class Alert {
    
    static func getDoneAlert(with message: String) {
        let statusAlert = StatusAlert()
        statusAlert.image = UIImage(systemName: "heart.fill")
        statusAlert.canBePickedOrDismissed = true
        statusAlert.message = message
        statusAlert.showInKeyWindow()
    }
}
