//
//  MapAndTableViewController.swift
//  iXplore
//
//  Created by Jordan Donald on 6/9/16.
//  Copyright © 2016 Jordan Donald. All rights reserved.
//

import UIKit
import MapKit

class MapAndTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var tableView: UITableView!
    
    var placeList = [Place]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.placeList = Place.placeList()
        self.setupMapView()
        self.setUpTableView()
        
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
        tableView.registerNib(UINib(nibName: "PlaceTableViewCell" , bundle: nil), forCellReuseIdentifier: "placeTableViewCell")
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.placeList.count
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        let place = placeList[indexPath.row]
      
        let cell = tableView.dequeueReusableCellWithIdentifier("placeTableViewCell", forIndexPath: indexPath) as! PlaceTableViewCell
        
        cell.placeLabel.text = place.title
        cell.placeImage.imageFromUrl(place.logoURL!)
        
        let date = NSDate()
        let formatter = NSDateFormatter()
        formatter.locale = NSLocale.currentLocale()
        formatter.dateFormat = "MM/dd/yyyy HH:mm a"
        
        let converter = formatter.stringFromDate(date)
        
        cell.date.text = converter
        
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
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            placeList.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }
    }
    
    
}