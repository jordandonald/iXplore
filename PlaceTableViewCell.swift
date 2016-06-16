//
//  PlaceTableViewCell.swift
//  iXplore
//
//  Created by Jordan Donald on 6/13/16.
//  Copyright © 2016 Jordan Donald. All rights reserved.
//

import UIKit

class PlaceTableViewCell: UITableViewCell {
    
    var view: UITableViewCell = UITableViewCell()
    var placeImage: UIImageView = UIImageView()
    var placeLabel: UILabel = UILabel()
    var dateLabel: UILabel = UILabel()
    var descriptionBox: UILabel = UILabel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let placeImageFrame = CGRectMake(0,0,88,88)
        placeImage = UIImageView(frame: placeImageFrame)
        placeImage.backgroundColor = UIColor.blueColor()
        self.addSubview(placeImage)
        
        let placeLabelFrame = CGRectMake(96,8,216,23)
        placeLabel = UILabel(frame: placeLabelFrame)
        placeLabel.text = "Title"
        self.addSubview(placeLabel)
        
        let dateLabelFrame = CGRectMake(96,33,216,21)
        dateLabel = UILabel(frame: dateLabelFrame)
        dateLabel.text = "Date"
        self.addSubview(dateLabel)
        
        let descriptionFrame = CGRectMake(96,53,216,30)
        descriptionBox = UILabel(frame: descriptionFrame)
        descriptionBox.text = "Enter Description"
        self.addSubview(descriptionBox)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func referenceCell(place: Place) {
        
        //image
        if let url = place.logoURL {
            placeImage.imageFromUrl(url)
        }
        
        //title
        placeLabel.text = place.title
        
        //date
        let date = NSDate()
        let formatter = NSDateFormatter()
        formatter.locale = NSLocale.currentLocale()
        formatter.dateFormat = "MM/dd/yyyy HH:mm a"
        
        let converter = formatter.stringFromDate(date)
        
        dateLabel.text = converter

    }

}

