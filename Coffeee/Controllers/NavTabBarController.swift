//
//  NavTabBarController.swift
//  Coffeee
//
//  Created by Nikita Melnikov on 03.03.2024.
//

import Foundation
import UIKit
import PTCardTabBar

class NavTabBarController: PTCardTabBarController {
    
    override func viewDidLoad() {
        let vc1 = FavoritesVC()
        let vc2 = MainVC()
        let vc3 = QrVC()
        
        vc1.tabBarItem = UITabBarItem(title: "", image: UIImage(systemName: "heart.fill"), tag: 1)
        vc2.tabBarItem = UITabBarItem(title: "", image: UIImage(systemName: "person.fill"), tag: 2)
        vc3.tabBarItem = UITabBarItem(title: "", image: UIImage(systemName: "qrcode"), tag: 3)
        
        self.viewControllers = [vc1, vc2, vc3]
        
        super.viewDidLoad()
    }
}
