//
//  AdvertiseCell.swift
//  
//
//  Created by Hiren-PC on 19/04/17.
//
//

import UIKit
import GoogleMobileAds

class AdvertiseCell: UITableViewCell {

    @IBOutlet weak var addView: GADBannerView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
