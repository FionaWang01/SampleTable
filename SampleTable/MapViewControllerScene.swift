//
//  MapViewControllerScene.swift
//  SampleTable
//
//  Created by babykang on 16/4/8.
//  Copyright © 2016年 babykang. All rights reserved.
//

import UIKit
import MapKit

class MapViewControllerScene: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    var resturant : Restaurant!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(resturant.location, completionHandler: {placemarks, error in
        
            if error != nil{
                print(error)
                return
            }
            
            if placemarks != nil && placemarks?.count > 0 {
                let placemake = placemarks![0] 
                
                // add annotation
                let annotation = MKPointAnnotation()
                annotation.title = self.resturant.name
                annotation.subtitle = self.resturant.type
                annotation.coordinate = (placemake.location?.coordinate)!
                
                self.mapView.showAnnotations([annotation], animated: true)
                self.mapView.selectAnnotation(annotation, animated: true)
                
            }
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "showMap"{
            let destinationController = segue.destinationViewController as! MapViewControllerScene
        destinationController.resturant = resturant
        
    }
}
}

extension MapViewControllerScene: MKMapViewDelegate{
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        let identifier = "MyPin"
        if annotation.isKindOfClass(MKUserLocation){
            return nil
        }
         // Reuse the annotation if possible
        
        var annotationView = mapView.dequeueReusableAnnotationViewWithIdentifier(identifier)
        
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
        }
        
        let leftIconView = UIImageView(frame: CGRectMake(0, 0, 53, 53))
        leftIconView.image = UIImage(named: resturant.image)
        annotationView?.leftCalloutAccessoryView = leftIconView
        
        return annotationView
        
    }
    
}







