//
//  MapAndTableViewController.swift
//  iXplore
//
//  Created by Jordan Donald on 6/9/16.
//  Copyright © 2016 Jordan Donald. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapAndTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, MKMapViewDelegate, UINavigationControllerDelegate, CLLocationManagerDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var tableView: UITableView!
    
    var placeList = [Place]()
    
    var locationStatus = ""
    
    var userCoordinate = CLLocationCoordinate2D()
    
    var locationManager = CLLocationManager()
    
    let newPlaceViewController = NewPlaceViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.placeList = NewPlaceViewController.sharedInstance.getPlace()
        self.setupMapView()
        self.setUpTableView()
        self.mapView.delegate = self
        locationManager.delegate = self
        
        // Ask for Authorization from the User.
        //self.locationManager.requestAlwaysAuthorization()
        
        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        
        }
        
//        let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
//        
//        appDelegate.locationManager = self.locationManager
//        
    }
    
    override func viewWillAppear(animated: Bool) {
        let plusButton = UIButton()
        plusButton.backgroundColor = UIColor.blackColor()
        plusButton.frame = CGRectMake(0, 0, 20, 20)
        plusButton.layer.cornerRadius = plusButton.frame.size.width/2
        plusButton.setTitle("+", forState: UIControlState.Normal)
        
        plusButton.addTarget(self, action: #selector(self.buttonTapped), forControlEvents: .TouchUpInside)

        
        let rightBarButton = UIBarButtonItem()
        rightBarButton.customView = plusButton
        self.navigationItem.rightBarButtonItem = rightBarButton
        
        placeList = PlacesController.sharedInstance.getPlaces()
        print(placeList[0].coordinate.latitude)
        print(placeList[0].coordinate.longitude)
        mapView.addAnnotations(placeList)
        tableView.reloadData()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func locationManager( manager: CLLocationManager , didChangeAuthorizationStatus status: CLAuthorizationStatus ){
        
//        var shouldIAllow = false
//        
//        switch status {
//            case CLAuthorizationStatus.Restricted: locationStatus = "Restricted Access to location"
//            case CLAuthorizationStatus.Denied: locationStatus = "User denied access to location"
//            case CLAuthorizationStatus.NotDetermined:locationStatus = "Status not determined"
//            locationManager.requestWhenInUseAuthorization()
//            default:
//                locationStatus = "Allowed to location Access"
//                shouldIAllow = true
//        }
//
//        NSNotificationCenter.defaultCenter().postNotificationName("LabelHasbeenUpdated", object: nil)
//            if (shouldIAllow == true) {
//                NSLog("Location to Allowed")
//                print("hey")
//                // Start location services
//                print(locationManager.delegate)
//                locationManager.startUpdatingLocation()
//            } else {
//                NSLog("Denied access: \(locationStatus)")
////                self.userLocation = CLLocation(latitude: 0, longitude: 0)
//            }
        print(CLLocationManager.locationServicesEnabled())
        locationManager.startUpdatingLocation()
        
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        userCoordinate = locations[locations.count - 1].coordinate
        print("hello")
        print(userCoordinate)
    }
    
    func buttonTapped(sender button:UIButton) {
        
        print("button tapped")
        self.presentViewController(newPlaceViewController, animated: true, completion: nil)
        newPlaceViewController.latitudeField.text = String(userCoordinate.latitude as Double)
        newPlaceViewController.longitudeField.text = String(userCoordinate.longitude as Double)
        
    }
    
    func setupMapView() {
        
        mapView.mapType = .Hybrid
        self.mapView.showsBuildings = true
        
        mapView.addAnnotations(placeList)
        
    }
    
    func setUpTableView() {
        
        self.tableView.allowsSelectionDuringEditing = true
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.registerClass(PlaceTableViewCell.self, forCellReuseIdentifier: "placeTableViewCell")
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.placeList.count
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        let place = placeList[indexPath.row]
      
        let cell = tableView.dequeueReusableCellWithIdentifier("placeTableViewCell", forIndexPath: indexPath) as! PlaceTableViewCell
        
        cell.referenceCell(place)
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let place = placeList[indexPath.row]
        mapView.selectAnnotation(place, animated: true)
        
        let mapCenterCoordinateAfterMove = CLLocationCoordinate2D(latitude: self.placeList[indexPath.row].coordinate.latitude,longitude: self.placeList[indexPath.row].coordinate.longitude)
        let adjustedRegion = mapView.regionThatFits(MKCoordinateRegionMake(mapCenterCoordinateAfterMove,
            MKCoordinateSpanMake(0.01, 0.01)))
        mapView.setRegion(adjustedRegion, animated: true)
        
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return CGFloat(88)
    }
    
    func deleteCell(indexPath: NSIndexPath) {
        mapView.removeAnnotation(placeList[indexPath.row])
        placeList.removeAtIndex(indexPath.row)
        tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
    }
    
    func favoriteCell(indexPath: NSIndexPath) {
        mapView.removeAnnotation(placeList[indexPath.row])
        placeList[indexPath.row].favorite = true
        mapView.addAnnotation(placeList[indexPath.row])
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        
        let action1 = UITableViewRowAction(style: .Normal, title: "Favorite") { action, index in
            print("Cell favorited")
            self.favoriteCell(indexPath)
        }
        action1.backgroundColor = UIColor.orangeColor()
        
        let action2 = UITableViewRowAction(style: .Normal, title: "Delete") { action, index in
            print("Cell deleted")
            self.deleteCell(indexPath)
        }
        action2.backgroundColor = UIColor.redColor()
        
        return [action1, action2]
    }
    
    
    func mapView(mapView: MKMapView!,viewForAnnotation annotation: MKAnnotation!) -> MKAnnotationView! {
        
        let pin = annotation as! Place
        
        if !(pin.favorite){
            return nil
        }

        let reuseId = "pin"
        
        var pinView = mapView.dequeueReusableAnnotationViewWithIdentifier(reuseId) as? MKPinAnnotationView
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView!.canShowCallout = true
            pinView!.animatesDrop = true
            pinView!.pinTintColor = UIColor.yellowColor()
        }
        else {
            pinView!.annotation = annotation
        }
        
        
        return pinView
    }
    
}