//
//  NewPlaceViewController.swift
//  iXplore
//
//  Created by Jordan Donald on 6/14/16.
//  Copyright © 2016 Jordan Donald. All rights reserved.
//

import UIKit
import MapKit

class NewPlaceViewController: UIViewController, UINavigationControllerDelegate {
    
    
    @IBOutlet weak var titleField: UITextField!
    
    @IBOutlet weak var descriptionField: UITextField!
    
    @IBOutlet weak var latitudeField: UITextField!
    
    @IBOutlet weak var longitudeField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view
        
        let currentPlace = PersistenceManager.loadObject("UserArchive")
        
        if let currentPlace = currentPlace as? Place{
            
            titleField.text = currentPlace.title
            descriptionField.text = currentPlace.descriptionField
            latitudeField.text = currentPlace.latitude
            longitudeField.text = currentPlace.longitude
            
        }
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
 
    @IBAction func backButtonTapped(sender: UIButton) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    @IBAction func saveButtonTapped(sender: UIButton) {
        
        let place = Place()
        
        place.title = titleField.text
        place.descriptionField = descriptionField.text!
    
        let latitude = (latitudeField.text! as NSString).doubleValue
        let longitude = (longitudeField.text! as NSString).doubleValue
        let location: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: latitude,longitude: longitude)
        
        place.coordinate = location
        
        
        PersistenceManager.saveObject(place, fileName: "PlaceArchive")
    }
    

}
