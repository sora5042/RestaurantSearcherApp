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
       
    @IBOutlet weak var shopDetailTableView: UITableView!
    @IBOutlet weak var shopImageView: UIImageView!
    @IBOutlet weak var backButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    private func setupView() {
        
        shopImageView.layer.cornerRadius = 120
        
        shopDetailTableView.delegate = self
        shopDetailTableView.dataSource = self
        shopDetailTableView.register(UINib(nibName: "ShopDetailTableViewCell", bundle: nil), forCellReuseIdentifier: cellId)
        backButton.addTarget(self, action: #selector(tappedBackButton), for: .touchUpInside)
        
        if let url = URL(string:shopDetail?.photo.pc.l ?? "" ) {
            Nuke.loadImage(with: url, into: shopImageView)
        }
    }
    
    @objc private func tappedBackButton() {
        
        dismiss(animated: true, completion: nil)
    }
}


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

