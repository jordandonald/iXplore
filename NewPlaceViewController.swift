//
//  NewPlaceViewController.swift
//  iXplore
//
//  Created by Jordan Donald on 6/14/16.
//  Copyright © 2016 Jordan Donald. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class NewPlaceViewController: UIViewController, UINavigationControllerDelegate {
    
    
    @IBOutlet weak var titleField: UITextField!
    
    @IBOutlet weak var descriptionField: UITextField!
    
    @IBOutlet weak var latitudeField: UITextField!
    
    @IBOutlet weak var longitudeField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
 
    @IBAction func backButtonTapped(sender: UIButton) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    @IBAction func saveButtonTapped(sender: UIButton) {
        
        let latitude = (latitudeField.text! as NSString).doubleValue
        let longitude = (longitudeField.text! as NSString).doubleValue
        
        PlacesController.sharedInstance.addPlace(titleField.text, descriptionField: descriptionField.text, logoURL: nil, ratable: nil, date: nil, favorite: nil, latitude: latitude, longitude: longitude)
        
    }
    

}
