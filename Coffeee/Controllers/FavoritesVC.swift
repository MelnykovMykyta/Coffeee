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
            .compactMap { $0 }
            .map { favoriteArray in
                return favoriteArray.sorted { ($0.value["name"] as? String ?? "") < ($1.value["name"] as? String ?? "") }
            }
            .bind(to: tableView.rx.items(cellIdentifier: "MenuItemTVC", cellType: MenuItemTVC.self)) { row, itemData, cell in
                guard let item = MenuItem.parse(from: itemData.value),
                      let url = URL(string: item.icon) else {
                    return
                }
                cell.nameLabel.text = item.name
                cell.priceLabel.text = "\(item.price)"
                cell.descLabel.text = item.ingredients
                cell.image.sd_setImage(with: url)
                cell.likeView.isHidden = false
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
        
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(longPress(_:)))
        tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.register(MenuItemTVC.self, forCellReuseIdentifier: "MenuItemTVC")
        tableView.addGestureRecognizer(longPressGesture)
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
    
    @objc private func longPress(_ gestureRecognizer: UILongPressGestureRecognizer) {
        guard gestureRecognizer.state == .began else { return }
        
        let touchPoint = gestureRecognizer.location(in: tableView)
        
        guard let indexPath = tableView.indexPathForRow(at: touchPoint),
              var favoriteArray = viewModel.favoriteRelay.value,
              indexPath.row < favoriteArray.count else { return }
        
        favoriteArray.sort { $0.value["name"] as? String ?? "" < $1.value["name"] as? String ?? "" }
        
        let selectedItem = favoriteArray[indexPath.row]
        
        Haptic.getHaptic()
        viewModel.removeFavorite(itemKey: selectedItem.key)
    }
}
