//
//  PlacesController.swift
//  iXplore
//
//  Created by Jordan Donald on 6/14/16.
//  Copyright © 2016 Jordan Donald. All rights reserved.
//

import Foundation

class PlacesController {
    
    var places: [Place] = []
    
    class var sharedInstance: PlacesController
    {
        struct Static
        {
            static var instance:PlacesController?
            static var token: dispatch_once_t = 0
        }
        
        dispatch_once(&Static.token)
        {
            Static.instance = PlacesController()
        }
        return Static.instance!
    }
    
    func addPlace (/*title: String, descriptionField: String*/){
        
        /*accepts all the attributes on the place model and the creates + store a new instance on the array. It should also persist the place.
         For now, only persist the title, date, coordinates, and description. The rest of fields should be nil.
         The date attribute of the place should be set to the date at the moment of adding the place. This can be done at the controller level. Perhaps look into default parameter values to achieve this default behaviour while allowing for custom dates to be sent later.*/
        
        //places.append()
        
    }
    
    private func readPlacesFromMemory (){
        /*populates the places array with all the methods stored in memory*/
    }
    
    func getPlaces(){
        /*returns the list of places. If the array is empty, the method should call the readPlacesFromMemory before returning the array. If the array is still empty after reading the disk, then it should return testing data.*/
    }
    
}


