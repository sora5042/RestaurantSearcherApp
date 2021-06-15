//
//  ShopDetailTableViewCell.swift
//  RestaurantSearcherApp
//
//  Created by 大谷空 on 2021/06/12.
//

import UIKit
import Nuke

class ShopDetailTableViewCell: UITableViewCell {
    
    var shopDetail: Shop? {
        didSet {
            
            shopNameLabel.text = shopDetail?.name
            catchLabel.text = shopDetail?.catch
            addressLabel.text = shopDetail?.address
            accessLabel.text = shopDetail?.access
            openLabel.text = shopDetail?.open
            parkingLabel.text = shopDetail?.parking
        }
    }
    
    @IBOutlet weak private var shopNameLabel: UILabel!
    @IBOutlet weak private var catchLabel: UILabel!
    @IBOutlet weak private var addressLabel: UILabel!
    @IBOutlet weak private var accessLabel: UILabel!
    @IBOutlet weak private var openLabel: UILabel!
    @IBOutlet weak private var parkingLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        shopNameLabel.layer.borderWidth = 1
        catchLabel.layer.borderWidth = 1
        addressLabel.layer.borderWidth = 1
        accessLabel.layer.borderWidth = 1
        openLabel.layer.borderWidth = 1
        parkingLabel.layer.borderWidth = 1
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    
    }
}
