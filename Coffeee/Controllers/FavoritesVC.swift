//
//  FavoritesVC.swift
//  Coffeee
//
//  Created by Nikita Melnikov on 03.03.2024.
//

import Foundation
import UIKit
import SnapKit
import SDWebImage

class FavoritesVC: UIViewController {
    
    private var tableView: UITableView!
    
    // DO Rx ????
    
    private var menu: [MenuItem] = [] {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
        NetworkService.getMenu(with: .coffee) { items in
            guard let menuItems = items else { return }
            self.menu = menuItems
        }
    }
}

private extension FavoritesVC {
    
    func setupView() {
        view.backgroundColor = D.Colors.mainBackgroundColor
        
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.register(MenuItemTVC.self, forCellReuseIdentifier: "MenuItemTVC")
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { $0.edges.equalToSuperview() }
    }
}

extension FavoritesVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menu.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MenuItemTVC", for: indexPath) as? MenuItemTVC else {
            return UITableViewCell()
        }
        let item = menu[indexPath.row]
        
        cell.nameLabel.text = item.name
        cell.descLabel.text = item.ingredients
        cell.priceLabel.text = item.price.description
        
        if let url = URL(string: item.icon) {
            cell.image.sd_setImage(with: url)
        }
        
        cell.selectionStyle = .none
        
        return cell
    }
}
