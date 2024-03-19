//
//  MainVC.swift
//  Coffeee
//
//  Created by Nikita Melnikov on 03.03.2024.
//

import Foundation
import UIKit
import SnapKit


class MainVC: UIViewController {
    
    private let viewModel = MainViewModel()
    private let authViewModel = AuthViewModel()
    private var user: User?
    private var tableView: UITableView!
    
    private var actions: [Action] = [] {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
        viewModel.getActions() { items in
            guard let actions = items else { return }
            self.actions = actions
        }
    }
    
    @objc func tap() {
        authViewModel.signOut()
        VCChanger.changeVC(vc: PhoneAuthVC())
    }
}

private extension MainVC {
    
    func setupView() {
        view.backgroundColor = .blue
        
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.register(ActionItemTVC.self, forCellReuseIdentifier: "ActionItemTVC")
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
//        let signOut = UIButton(type: .system)
//        signOut.setTitle("Вихід", for: .normal)
//        signOut.addTarget(self, action: #selector(tap), for: .touchUpInside)
//        view.addSubview(signOut)
//        
//        signOut.snp.makeConstraints { $0.center.equalToSuperview() }
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
        cell.nameLabel.text = action.name
        
        if let url = URL(string: action.icon) {
            cell.image.sd_setImage(with: url)
        }
        
        return cell
    }
}
