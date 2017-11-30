//
//  MenuCell.swift
//  Algorithms
//
//  Created by Ledung95d on 4/11/17.
//  Copyright © 2017 LocTran. All rights reserved.
//

import UIKit

class MenuCell: UITableViewCell {

    @IBOutlet weak var imgCell: UIImageView!
    @IBOutlet weak var titleCell: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        
        
//

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        if selected {
            backgroundColor = UIColor(red: 255/255, green: 204/255, blue: 255/255, alpha: 1)

        }else{
            backgroundColor = UIColor(red: 255/255, green: 204/255, blue: 255/255, alpha: 0.3)
        }
        // Configure the view for the selected state
    }
    
}
