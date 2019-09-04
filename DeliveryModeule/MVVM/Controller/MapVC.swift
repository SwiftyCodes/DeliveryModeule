//
//  MapVC.swift
//  DeliveryModeule
//
//  Created by Anurag Kashyap on 04/09/19.
//  Copyright © 2019 Anurag Kashyap. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapVC: UIViewController {

    @IBOutlet weak var mapView :MKMapView!
    private let locationManager = CLLocationManager()
    
    var mapValue : DeliveryVM? = nil
    let annotation = MKPointAnnotation()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.startUpdatingLocation()
        
        self.mapView.showsUserLocation = true
        
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        let annotations = self.mapView.annotations
        self.mapView.removeAnnotations(annotations)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        showAnnotation()
    }

    
    func showAnnotation() {
        if let locationDet = mapValue {
            self.annotation.coordinate = CLLocationCoordinate2D(latitude: (locationDet.locationDetails?.latitude)!, longitude: (locationDet.locationDetails?.longitude)!)
            let placeMarkCreated = MKPlacemark(coordinate: (annotation.coordinate))
            print(locationDet.locationDetails?.latitude, ":",locationDet.locationDetails?.longitude )
            addAnnotationToMap(placemark: placeMarkCreated)
        }
    }
    
    
    
    //Adding annotation
    private func addAnnotationToMap(placemark :CLPlacemark) {
        let coordinate = placemark.location?.coordinate
        let annotation = MKPointAnnotation()
        annotation.title = placemark.name
        annotation.subtitle = placemark.subLocality
        annotation.coordinate = coordinate!
        self.mapView.setRegion(MKCoordinateRegion(center: self.annotation.coordinate, latitudinalMeters: 200, longitudinalMeters: 200), animated: true)
        self.mapView.addAnnotation(annotation)
        locationManager.stopUpdatingLocation()
        
    }
}


extension MapVC : MKMapViewDelegate {
    
}

extension MapVC : CLLocationManagerDelegate{
    
}
