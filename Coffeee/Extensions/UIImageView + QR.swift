//
//  UIImageView + QR.swift
//  Coffeee
//
//  Created by Nikita Melnikov on 15.03.2024.
//

import Foundation
import UIKit
import SimpleQRCode

extension UIImageView {
    convenience init(qrCode: QRCode) {
        self.init(image: qrCode.unsafeImage)
    }
}
