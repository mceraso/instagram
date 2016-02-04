//
//  InstaTableViewCell.swift
//  
//
//  Created by Michael Ceraso on 2/4/16.
//
//

import UIKit

class InstaTableViewCell: UITableViewCell {
    
    @IBOutlet weak var usernameText: UILabel!
    @IBOutlet weak var profilePhoto: UIImageView!
    @IBOutlet weak var TopPhoto: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
