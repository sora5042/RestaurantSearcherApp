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
    
    @IBOutlet weak var shopNameLabel: UILabel!
    @IBOutlet weak var catchLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var accessLabel: UILabel!
    @IBOutlet weak var openLabel: UILabel!
    @IBOutlet weak var parkingLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

       
    }
    
}
