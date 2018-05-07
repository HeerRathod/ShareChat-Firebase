//
//  DashboardCell.swift
//  ShareChat
//
//  Created by Hiren-PC on 12/04/17.
//  Copyright © 2017 com.suflamtech. All rights reserved.
//

import UIKit
import GoogleMobileAds

class DashboardCell: UITableViewCell {

    @IBOutlet weak var addView: GADBannerView!
    @IBOutlet weak var lblmessage: UILabel!
    

    @IBOutlet weak var btnTag: UIButton!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var btnShare: UIButton!
    
    @IBOutlet weak var btnComplain: UIButton!
    
    @IBOutlet weak var btnWhatsApp: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
