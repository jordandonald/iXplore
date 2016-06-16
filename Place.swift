//
//  Place.swift
//  iXplore
//
//  Created by Jordan Donald on 6/13/16.
//  Copyright © 2016 Jordan Donald. All rights reserved.
//

import Foundation
import MapKit

class Place:NSObject, MKAnnotation {
    
    var coordinate: CLLocationCoordinate2D = CLLocationCoordinate2D()
    var title: String? = ""
    var logoURL:String?
    var ratable:Bool = true
    var date: NSDate = NSDate()
    var favorite:Bool = false
    var descriptionField: String? = ""
    
    required convenience init(title:String?, date:NSDate?, coordinate:CLLocationCoordinate2D, descriptionField:String?) {
        
        self.init()
        self.title = title
        if let date = date {
            self.date = date
        }
        self.coordinate = coordinate
        self.descriptionField = descriptionField
    }
    
    // MARK: - NSCoding
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(self.title, forKey: "title")
        aCoder.encodeObject(self.date, forKey: "date")
        aCoder.encodeObject(coordinate.latitude, forKey: "latitude")
        aCoder.encodeObject(coordinate.longitude, forKey: "longitude")
        aCoder.encodeObject(self.descriptionField, forKey: "descriptionField")
        
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        
        let title = aDecoder.decodeObjectForKey("title") as? String
        let date = aDecoder.decodeObjectForKey("date") as? NSDate
        let latitude = aDecoder.decodeObjectForKey("latitude") as? Double
        let longitude = aDecoder.decodeObjectForKey("longitude") as? Double
        let descriptionField = aDecoder.decodeObjectForKey("descriptionField") as? String
        
        let coordinate = CLLocationCoordinate2D(latitude: latitude!, longitude: longitude!)
        
        self.init(title:title, date:date, coordinate:coordinate, descriptionField:descriptionField)
        
    }

    
    class func placeList() -> [Place] {
        
        let place = Place()
        place.title = "Workshop 17"
        place.logoURL = "https://avatars1.githubusercontent.com/u/7220596?v=3&s=200"
        place.coordinate = CLLocationCoordinate2D(latitude: -33.906764,longitude: 18.4164983)
        
        let place2 = Place()
        place2.title = "Truth Coffee"
        place2.ratable = false
        place2.logoURL = "https://robohash.org/123.png"
        place2.coordinate = CLLocationCoordinate2D(latitude: -33.9281976,longitude: 18.4227045)
        
        let place3 = Place()
        place3.title = "Chop Chop Coffee"
        place3.ratable = true
        place3.logoURL = "http://cdn3.ixperience.co.za/assets/icons/interview-step-2-801f63110f89e85e38f27d39f5864a1399f256fe0684844caea2a18c4b6fbd33.svg"
        place3.coordinate = CLLocationCoordinate2D(latitude: -33.9271879,longitude: 18.4327055)
        
        return [place, place2, place3]
    }
    
    class func aPlace () -> Place {
        
        let place = Place()
        place.title = "Workshop 17"
        place.coordinate = CLLocationCoordinate2D(latitude: -33.906764,longitude: 18.4164983)
        return place
    }
    
}

extension UIImageView   {


    public func imageFromUrl(urlString: String) {
        if let url = NSURL(string: urlString) {
            let request = NSURLRequest(URL: url)
            NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) {
                (response: NSURLResponse?, data: NSData?, error: NSError?) -> Void in
                if let imageData = data as NSData? {
                    self.image = UIImage(data: imageData)
                }
            }
        }
    }

}

