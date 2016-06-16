//
//  PlacesController.swift
//  iXplore
//
//  Created by Jordan Donald on 6/14/16.
//  Copyright © 2016 Jordan Donald. All rights reserved.
//

import Foundation
import MapKit

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
    
    func addPlace (title: String?, descriptionField: String?, logoURL:String?, ratable: Bool?, date: NSDate?, favorite: Bool?, latitude: Double, longitude: Double){
        
        let place = Place()
        
        place.title = title
        place.descriptionField = descriptionField
        place.logoURL = logoURL
        
        if let ratable = ratable {
           place.ratable = ratable
        }
        
        if let date = date {
            place.date = date
        }
        
        if let favorite = favorite {
            place.favorite = favorite
        }
        
        place.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        
        places.append(place)
        
        PersistenceManager.saveNSArray(places, fileName: "PlaceArchive")
        
    }
    
    private func readPlacesFromMemory (){
        /*populates the places array with all the places stored in memory*/
      
        if let placeList = PersistenceManager.loadNSArray("PlaceArchive") as? [Place] {
            places = placeList
        }
        
    }
    
    func getPlaces() -> [Place]{
        /*returns the list of places. If the array is empty, the method should call the readPlacesFromMemory before returning the array. If the array is still empty after reading the disk, then it should return testing data.*/
        
        readPlacesFromMemory()
        
        if (places.count == 0){
            
            self.places = Place.placeList()
            PersistenceManager.saveNSArray(places, fileName: "PlaceArchive")
            
        }
        
        return self.places
    }
    
}


