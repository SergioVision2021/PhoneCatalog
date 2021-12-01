//
//  XibTableViewCell.swift
//  PhonesData
//
//  Created by Apple on 1.12.21.
//

import UIKit

class XibTableViewCell: UITableViewCell {

    @IBOutlet weak var imageIV: UIImageView!
    @IBOutlet weak var brandTF: UILabel!
    @IBOutlet weak var nameTF: UILabel!
    @IBOutlet weak var osTF: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
