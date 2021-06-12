//
//  SearchShopResulrViewController.swift
//  RestaurantSearcherApp
//
//  Created by 大谷空 on 2021/06/12.
//

import UIKit

class SearchShopResulrViewController: UIViewController {
    
    private let cellId = "cellId"
    var shopData = [Shop]()
    
    @IBOutlet weak var searchShopResultTableView: UITableView!
    @IBOutlet weak var backButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    private func setupView() {
        
        backButton.addTarget(self, action: #selector(tappedBackButton), for: .touchUpInside)
        searchShopResultTableView.delegate = self
        searchShopResultTableView.dataSource = self
        searchShopResultTableView.register(UINib(nibName: "SearchShopResultTableViewCell", bundle: nil), forCellReuseIdentifier: cellId)
    }
    
    @objc private func tappedBackButton() {
        
        dismiss(animated: true, completion: nil)
    }
}

extension SearchShopResulrViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 200
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return shopData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = searchShopResultTableView.dequeueReusableCell(withIdentifier: cellId) as! SearchShopResultTableViewCell
        
        cell.shopDetail = shopData[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let shopDetailViewController = UIStoryboard(name: "ShopDetail", bundle: nil).instantiateViewController(withIdentifier: "ShopDetailViewController") as! ShopDetailViewController
        
        shopDetailViewController.modalPresentationStyle = .fullScreen
        shopDetailViewController.shopDetail = self.shopData[indexPath.row]
        self.present(shopDetailViewController, animated: true, completion: nil)
    }
}
