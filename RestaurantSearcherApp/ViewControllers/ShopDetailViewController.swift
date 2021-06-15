//
//  ShopDetailViewController.swift
//  RestaurantSearcherApp
//
//  Created by 大谷空 on 2021/06/09.
//

import UIKit
import Nuke

class ShopDetailViewController: UIViewController {
    
    private let cellId = "cellId"
    var shopDetail: Shop? 
       
    @IBOutlet weak private var shopDetailTableView: UITableView!
    @IBOutlet weak private var shopImageView: UIImageView!
    @IBOutlet weak private var backButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    // MARK: - Method
    private func setupView() {
                
        shopDetailTableView.delegate = self
        shopDetailTableView.dataSource = self
        shopDetailTableView.register(UINib(nibName: "ShopDetailTableViewCell", bundle: nil), forCellReuseIdentifier: cellId)
        backButton.addTarget(self, action: #selector(tappedBackButton), for: .touchUpInside)
        
        if let url = URL(string:shopDetail?.photo.pc.l ?? "" ) {
            Nuke.loadImage(with: url, into: shopImageView)
        }
        
        shopImageView.layer.borderWidth = 1
    }
    
    @objc private func tappedBackButton() {
        
        dismiss(animated: true, completion: nil)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        
        return .darkContent
    }
}

// MARK: - ShopDetailViewController: UITableViewDelegate, UITableViewDataSource
extension ShopDetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 600
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = shopDetailTableView.dequeueReusableCell(withIdentifier: cellId) as! ShopDetailTableViewCell
        
        cell.shopDetail = shopDetail
        
        return cell
    }
}
