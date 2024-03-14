//
//  MenuSectionVC.swift
//  Coffeee
//
//  Created by Nikita Melnikov on 14.03.2024.
//

import Foundation
import UIKit
import SnapKit
import SDWebImage
import TabsPager

class MenuSectionVC: TabsPagerContentVC {
    
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
        
        guard let value = Menu.allCases.first(where: { $0.index == pageIndex }) else { return }
        
        NetworkService.getMenu(with: value) { items in
            guard let menuItems = items else { return }
            self.menu = menuItems
        }
    }
}

private extension MenuSectionVC {
    
    func setupView() {
        view.backgroundColor = D.Colors.mainBackgroundColor
        
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.register(MenuItemTVC.self, forCellReuseIdentifier: "MenuItemTVC")
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(20)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
}

extension MenuSectionVC: UITableViewDataSource, UITableViewDelegate {
    
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
