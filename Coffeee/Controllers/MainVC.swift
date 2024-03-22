//
//  MainVC.swift
//  Coffeee
//
//  Created by Nikita Melnikov on 03.03.2024.
//

import Foundation
import UIKit
import SnapKit
import Lottie
import MBCircularProgressBar
import FirebaseAuth
import RxSwift
import RxCocoa

protocol ActionDelegate: AnyObject {
    func didSelectAction(_ action: Action)
}

class MainVC: UIViewController {
    
    private let mainViewModel = MainViewModel()
    private let authViewModel = AuthViewModel()
    private let disposeBag = DisposeBag()
    private var user: User?
    private var actions: [Action] = []
    weak var delegateAction: ActionDelegate?
    
    private var greatingLabel: UILabel!
    private var logoutButton: UIButton!
    private var infoView: UIView!
    private var progressView: MBCircularProgressBarView!
    private var animationProgressView: LottieAnimationView!
    private var discountCountLabel: UILabel!
    private var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
        authViewModel.userObservable
            .subscribe(onNext: { [weak self] user in
                guard let user = user else { return }
                self?.user = user
                self?.greatingLabel.text = "Привіт, \(user.name) 👋"
                self?.discountCountLabel.text = "\(user.discount)%"
                self?.animation()
            }).disposed(by: disposeBag)
        
        mainViewModel.getActions() { items in
            guard let actions = items else { return }
            self.actions = actions
            self.tableView.reloadData()
        }
        
        authViewModel.getUser()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animation()
    }
    
    @objc func logout() {
        authViewModel.signOut()
        VCChanger.changeVC(vc: PhoneAuthVC())
    }
}

private extension MainVC {
    
    func setupView() {
        view.backgroundColor = D.Colors.mainBackgroundColor
        
        let topView = UIView()
        topView.backgroundColor = D.Colors.mainBackgroundColor
        view.addSubview(topView)
        
        logoutButton = UIButton(type: .system)
        logoutButton.setImage(UIImage(named: "logout"), for: .normal)
        logoutButton.tintColor = .black
        logoutButton.addTarget(self, action: #selector(logout), for: .touchUpInside)
        topView.addSubview(logoutButton)
        
        greatingLabel = UILabel()
        greatingLabel.textColor = .black
        greatingLabel.font = UIFont(name: "URWGeometric-SemiBold", size: 30)
        greatingLabel.adjustsFontSizeToFitWidth = true
        greatingLabel.adjustsFontForContentSizeCategory = true
        topView.addSubview(greatingLabel)
        
        infoView = UIView()
        infoView.backgroundColor = D.Colors.mainBackgroundColor
        view.addSubview(infoView)
        
        progressView = MBCircularProgressBarView()
        progressView.progressLineWidth = 10
        progressView.progressColor = D.Colors.nameColor
        progressView.progressAngle = 75
        progressView.value = 0
        progressView.progressStrokeColor = D.Colors.nameColor
        progressView.showUnitString = false
        progressView.showValueString = false
        progressView.backgroundColor = .clear
        infoView.addSubview(progressView)
        
        animationProgressView = LottieAnimationView(name: "progressAnimation")
        animationProgressView.contentMode = .scaleAspectFit
        animationProgressView.animationSpeed = 2
        infoView.addSubview(animationProgressView)
        
        discountCountLabel = UILabel()
        discountCountLabel.textColor = D.Colors.nameColor
        discountCountLabel.font = UIFont(name: "URWGeometric-SemiBold", size: 28)
        discountCountLabel.adjustsFontSizeToFitWidth = true
        discountCountLabel.adjustsFontForContentSizeCategory = true
        infoView.addSubview(discountCountLabel)
        
        let discountLabel = UILabel()
        discountLabel.text = D.Texts.discount
        discountLabel.textColor = D.Colors.nameColor
        discountLabel.font = UIFont(name: "URWGeometric-SemiBold", size: 32)
        discountLabel.adjustsFontSizeToFitWidth = true
        discountLabel.adjustsFontForContentSizeCategory = true
        infoView.addSubview(discountLabel)
        
        tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.register(ActionItemTVC.self, forCellReuseIdentifier: "ActionItemTVC")
        view.addSubview(tableView)
        
        topView.snp.makeConstraints {
            $0.height.equalTo(topView.snp.width).multipliedBy(0.2)
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        logoutButton.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(20)
            $0.trailing.equalToSuperview()
            $0.width.equalTo(logoutButton.snp.height)
        }
        
        greatingLabel.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.trailing.equalTo(logoutButton.snp.leading).inset(20)
        }
        
        infoView.snp.makeConstraints {
            $0.height.equalTo(infoView.snp.width).multipliedBy(0.5)
            $0.top.equalTo(topView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
        }
        
        progressView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.height.equalToSuperview().multipliedBy(0.8)
            $0.width.equalTo(progressView.snp.height)
        }
        
        animationProgressView.snp.makeConstraints {
            $0.edges.equalTo(progressView.snp.edges).inset(20)
        }
        
        discountCountLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        discountLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(animationProgressView.snp.bottom).inset(-20)
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(infoView.snp.bottom).inset(-20)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    func animation() {
        guard let user = user else { return }
        let progress: Double = Double(user.discount) / 100.0
        animationProgressView.play(toProgress: progress, loopMode: .playOnce)
        UIView.animate(withDuration: 1.0, animations: {
            self.progressView.value = CGFloat(progress) * 100.0
        })
    }
}

extension MainVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return actions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ActionItemTVC", for: indexPath) as? ActionItemTVC else {
            return UITableViewCell()
        }
        
        let action = actions[indexPath.row]
        cell.image.image = nil
        cell.nameLabel.text = action.name
        
        if let url = URL(string: action.icon) {
            cell.image.sd_setImage(with: url)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 50))
        headerView.backgroundColor = D.Colors.mainBackgroundColor
        
        let headerLabel = UILabel()
        headerLabel.text = D.Texts.actions
        headerLabel.font = UIFont(name: "URWGeometric-SemiBold", size: 20)
        headerLabel.textColor = .black.withAlphaComponent(0.5)
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        headerView.addSubview(headerLabel)
        
        headerLabel.snp.makeConstraints {
            $0.centerY.equalTo(headerView)
            $0.leading.equalTo(headerView).inset(20)
        }
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let action = actions[indexPath.row]
        let vc = ActionInfoVC()
        delegateAction = vc
        present(vc, animated: true)
        delegateAction?.didSelectAction(action)
    }
}
