//
//  PlaceTableViewCell.swift
//  iXplore
//
//  Created by Jordan Donald on 6/13/16.
//  Copyright © 2016 Jordan Donald. All rights reserved.
//

import UIKit

class PlaceTableViewCell: UITableViewCell {

    
    @IBOutlet weak var placeLabel: UILabel!
    
    @IBOutlet weak var placeImage: UIImageView!
   
    @IBOutlet weak var date: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
