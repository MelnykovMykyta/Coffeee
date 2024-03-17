//
//  Haptic.swift
//  Coffeee
//
//  Created by Nikita Melnikov on 17.03.2024.
//

import Foundation
import UIKit

class Haptic {
    
    static func getHaptic() {
        let haptic = UIImpactFeedbackGenerator(style: .medium)
        haptic.impactOccurred()
    }
}
