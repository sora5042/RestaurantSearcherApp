//
//  SearchShopResulrViewController.swift
//  RestaurantSearcherApp
//
//  Created by 大谷空 on 2021/06/12.
//

import UIKit

class SearchShopResultViewController: UIViewController {
    
    private let cellId = "cellId"
    var shopData = [Shop]()
    
    @IBOutlet weak private var searchShopResultTableView: UITableView!
    @IBOutlet weak private var backButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    //MARK: - Method
    private func setupView() {
        
        backButton.addTarget(self, action: #selector(tappedBackButton), for: .touchUpInside)
        searchShopResultTableView.delegate = self
        searchShopResultTableView.dataSource = self
        searchShopResultTableView.register(UINib(nibName: "SearchShopResultTableViewCell", bundle: nil), forCellReuseIdentifier: cellId)
    }
    
    @objc private func tappedBackButton() {
        
        dismiss(animated: true, completion: nil)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        
        return .darkContent
    }
}

// MARK: - SearchShopResulrViewController: UITableViewDelegate, UITableViewDataSource
extension SearchShopResultViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 200
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return shopData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = searchShopResultTableView.dequeueReusableCell(withIdentifier: cellId) as! SearchShopResultTableViewCell
        
        cell.shopDetail = shopData[indexPath.row]
        
        let selectionView = UIView()
        
        selectionView.backgroundColor = UIColor.systemOrange
        cell.selectedBackgroundView = selectionView
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let shopDetailViewController = UIStoryboard(name: "ShopDetail", bundle: nil).instantiateViewController(withIdentifier: "ShopDetailViewController") as! ShopDetailViewController
        shopDetailViewController.modalPresentationStyle = .fullScreen
        shopDetailViewController.shopDetail = self.shopData[indexPath.row]
        self.present(shopDetailViewController, animated: true, completion: nil)
    }
}
