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
    
    var spotList = [Spot]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.spotList = Spot.spotList()
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
        
        for spots in spotList{
            
            self.mapView.addAnnotation(spots)
        }
        
    }
    
    func setUpTableView() {
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        tableView.registerNib(UINib(nibName: "SpotTableViewCell" , bundle: nil), forCellReuseIdentifier: "spotTableViewCell")
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.spotList.count
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        let spot = spotList[indexPath.row]
//        let cell = UITableViewCell()
//        cell.textLabel?.text = spot.title
        
        var cell = tableView.dequeueReusableCellWithIdentifier("spotTableViewCell", forIndexPath: indexPath) as! SpotTableViewCell
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let spot = spotList[indexPath.row]
        mapView.selectAnnotation(spot, animated: true)
        
        let mapCenterCoordinateAfterMove = CLLocationCoordinate2D(latitude: self.spotList[indexPath.row].coordinate.latitude,longitude: self.spotList[indexPath.row].coordinate.longitude)
        let adjustedRegion = mapView.regionThatFits(MKCoordinateRegionMake(mapCenterCoordinateAfterMove,
            MKCoordinateSpanMake(0.01, 0.01)))
        mapView.setRegion(adjustedRegion, animated: true)
        
    }
    
    
}