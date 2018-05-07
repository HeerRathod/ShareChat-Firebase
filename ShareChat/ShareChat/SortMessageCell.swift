//
//  SortMessageCell.swift
//  ShareChat
//
//  Created by Hiren-PC on 21/04/17.
//  Copyright © 2017 com.suflamtech. All rights reserved.
//

import UIKit

class SortMessageCell: UITableViewCell {

    @IBOutlet weak var sortView: UIView!
    
    @IBOutlet weak var lblMessage: UILabel!
    
    @IBOutlet weak var lblTag: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var btnComplaint: UIButton!
    @IBOutlet weak var btnWhatsApp: UIButton!
    @IBOutlet weak var btnShare: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
