//
//  FavoritesVC.swift
//  Coffeee
//
//  Created by Nikita Melnikov on 03.03.2024.
//

import Foundation
import UIKit
import SnapKit
import RxSwift
import RxCocoa

class FavoritesVC: UIViewController {
    
    private let viewModel = FavoriteViewModel()
    private var disposeBag = DisposeBag()
    private var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
        viewModel.favoriteObservable
            .map { favorites in
                return favorites.compactMap { $0 }
            }
            .map { elements in
                return elements.sorted { $0.name < $1.name }
            }
            .bind(to: tableView.rx.items(cellIdentifier: "MenuItemTVC", cellType: MenuItemTVC.self)) { row, element, cell in
                guard let url = URL(string: element.icon) else { return }
                cell.nameLabel.text = element.name
                cell.priceLabel.text = "\(element.price)"
                cell.descLabel.text = element.ingredients
                cell.image.sd_setImage(with: url)
            }.disposed(by: disposeBag)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.getFavorite()
    }
}

extension FavoritesVC {
    
    func setupView() {
        view.backgroundColor = D.Colors.mainBackgroundColor
        
        let label = UILabel()
        label.text = D.Texts.favoriteLabel
        label.font =  UIFont(name: "URWGeometric-SemiBold", size: 28)
        view.addSubview(label)
        
        tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.register(MenuItemTVC.self, forCellReuseIdentifier: "MenuItemTVC")
        view.addSubview(tableView)
        
        label.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(20)
            $0.centerX.equalToSuperview()
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(label.snp.bottom).inset(-20)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
}
