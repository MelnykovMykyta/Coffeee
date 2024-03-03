//
//  FirstLaunchChecker.swift
//  Coffeee
//
//  Created by Nikita Melnikov on 03.03.2024.
//

import Foundation

class FirstLaunchChecker {
    
    static func check() {
        
        let firstLaunch = UserDefaults.standard.bool(forKey: "firstLaunch")
        
        if firstLaunch  {
            VCChanger.changeVC(vc: NavTabBarController())
        } else {
            UserDefaults.standard.set(true, forKey: "firstLaunch")
            VCChanger.changeVC(vc: GuideVC())
        }
    }
}