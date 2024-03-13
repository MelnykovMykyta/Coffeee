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
    private var label: UILabel!
    
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
        
        label = UILabel()
        label.text = D.Texts.animation
        label.font = UIFont(name: "URWGeometric-SemiBold", size: 80)
        label.adjustsFontSizeToFitWidth = true
        label.textColor = D.Colors.nameColor
        label.textAlignment = .center
        view.addSubview(label)
        
        animatedView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.7)
            $0.height.equalTo(animatedView.snp.width)
        }
        
        label.snp.makeConstraints {
            $0.top.equalTo(animatedView.snp.bottom).inset(-20)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
    }
    
    func animation() {
        animatedView.play(fromProgress: 0, toProgress: 0.9) { completed in
            UIView.animate(withDuration: 1, animations: {
                self.animatedView.alpha = 0
                self.label.alpha = 0
            }) { _ in
                FirstLaunchChecker.check()
            }
        }
    }
}
