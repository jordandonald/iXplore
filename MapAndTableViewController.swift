//
//  MapAndTableViewController.swift
//  iXplore
//
//  Created by Jordan Donald on 6/9/16.
//  Copyright © 2016 Jordan Donald. All rights reserved.
//

import UIKit
import MapKit

class MapAndTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var tableView: UITableView!
    
    var placeList = [Place]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.placeList = Place.placeList()
        self.setupMapView()
        self.setUpTableView()
        self.mapView.delegate = self
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupMapView() {
        
        mapView.mapType = .Hybrid
        self.mapView.showsBuildings = true
        
        for places in placeList{
            
            self.mapView.addAnnotation(places)
        }
        
    }
    
    func setUpTableView() {
        
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
        
        //cell.placeLabel.text = place.title
        //cell.placeImage.imageFromUrl(place.logoURL!)
        
//        let date = NSDate()
//        let formatter = NSDateFormatter()
//        formatter.locale = NSLocale.currentLocale()
//        formatter.dateFormat = "MM/dd/yyyy HH:mm a"
//        
//        let converter = formatter.stringFromDate(date)
        
        //cell.dateLabel.text = converter
        
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
    
//    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
//        if editingStyle == .Delete {
//            mapView.removeAnnotation(placeList[indexPath.row])
//            placeList.removeAtIndex(indexPath.row)
//            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
//        }
//    }
    
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
    
    
    func mapView(mapView: MKMapView!,
                 viewForAnnotation annotation: MKAnnotation!) -> MKAnnotationView! {
        
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