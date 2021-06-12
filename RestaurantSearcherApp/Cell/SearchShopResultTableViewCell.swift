//
//  TableViewCell.swift
//  RestaurantSearcherApp
//
//  Created by 大谷空 on 2021/06/12.
//

import UIKit
import Nuke

class SearchShopResultTableViewCell: UITableViewCell {
    
    var shopDetail: Shop? {
        didSet {
            
            if let url = URL(string: shopDetail?.photo.pc.l ?? "") {
                Nuke.loadImage(with: url, into: ShopImageView)
            }
            
            shopNameLabel.text = shopDetail?.name
            accessLabel.text = shopDetail?.access
            openLabel.text = shopDetail?.open
        }
    }
    
    @IBOutlet weak var ShopImageView: UIImageView!
    @IBOutlet weak var shopNameLabel: UILabel!
    @IBOutlet weak var accessLabel: UILabel!
    @IBOutlet weak var openLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        
        ShopImageView.layer.cornerRadius = 30
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
}
