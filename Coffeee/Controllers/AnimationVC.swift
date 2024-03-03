//
//  AnimationVC.swift
//  Coffeee
//
//  Created by Nikita Melnikov on 03.03.2024.
//

import Foundation
import UIKit
import SnapKit
import Lottie

class AnimationVC: UIViewController {
    
    private var animatedView: LottieAnimationView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        animation()
    }
}

private extension AnimationVC {
    
    func setupView() {
        view.backgroundColor = D.Colors.mainBackgroundColor
        
        animatedView = LottieAnimationView(name: "Animation")
        animatedView.contentMode = .scaleAspectFit
        view.addSubview(animatedView)
        
        animatedView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.horizontalEdges.equalToSuperview()
        }
    }
    
    func animation() {
        animatedView.play(fromProgress: 0, toProgress: 0.9) { completed in
            UIView.animate(withDuration: 1, animations: {
                self.animatedView.alpha = 0
            }) { _ in
                VCChanger.changeVC(vc: NavTabBarController())
            }
        }
    }
}
