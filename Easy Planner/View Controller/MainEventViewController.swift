//
//  MainEventViewController.swift
//  Easy Planner
//
//  Created by Marcos Tirao on 8/31/16.
//  Copyright © 2016 Marcos Tirao. All rights reserved.
//

import UIKit
import MapKit


private let eventNamePlaceHolder = "NewEvent"

let regionRadius: CLLocationDistance = 1000

class MainEventViewController: UIViewController {
    
    var contactViewController: ContactsViewController?
    var menuViewController: MenuViewController?
    var cloudEventViewControler: CloudEventViewController?
    
    var nameField : FieldView?
    var mapView : MKMapView?
    var timePicker : UIDatePicker?
    var locationButton : UIButton!
    var directionsButton : UIButton!
    
    var toolbar = [UIBarButtonItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameField = FieldView(frame: CGRect.zero, type: .text, label: "Name:")
        nameField?.placeHolder = "Give this event a name"
        self.view.addSubview(nameField!)
        nameField?.snp.makeConstraints{(make) -> Void in
            make.height.equalTo(45)
            make.leading.trailing.equalTo(self.view).inset(UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8))
            make.top.equalTo(68)
        }
        
        timePicker = UIDatePicker()
        timePicker!.datePickerMode = .time
        timePicker!.minuteInterval = 10
        self.view.addSubview(timePicker!)
        timePicker?.snp.makeConstraints{(make) -> Void in
            make.height.equalTo(180)
            make.leading.trailing.equalTo(self.view).inset(UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
            make.top.equalTo(nameField!.snp.bottom).offset(8)
        }
        
        mapView = MKMapView()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(MainEventViewController.tapOnMap(gesture:)))
        mapView?.addGestureRecognizer(tapGesture)
        mapView?.showsUserLocation = true
        mapView?.isScrollEnabled = true
        mapView?.delegate = self
        self.view.addSubview(mapView!)
        mapView?.snp.makeConstraints{(make) -> Void in
            make.bottom.equalTo(self.view.snp.bottom)
            make.top.equalTo(timePicker!.snp.bottom).offset(8)
            make.leading.trailing.equalTo(self.view).inset(UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8))
        }
        
        
        locationButton = UIButton(type: .custom)
        locationButton?.setImage(UIImage(named:"locationArrow"), for: .normal)
        locationButton?.setImage(UIImage(named:"locationArrow"), for: .highlighted)
        locationButton?.backgroundColor = UIColor.white
        locationButton?.layer.cornerRadius = 5
        locationButton?.tintColor =  Theme.barTint
        locationButton?.layer.shadowOffset = CGSize(width: 5, height: 5)
        locationButton?.layer.shadowColor = UIColor.gray.cgColor
        locationButton?.addTarget(self, action: #selector(MainEventViewController.useCurrentLocation), for: .touchUpInside)
        self.view.addSubview(locationButton)
        locationButton?.snp.makeConstraints{(make) -> Void in
            make.top.equalTo(self.mapView!.snp.top).offset(8)
            make.height.width.equalTo(35)
            make.right.equalTo(mapView!.snp.right).inset(UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 16))
        }
        
        directionsButton = UIButton(type: .custom)
        directionsButton?.setImage(UIImage(named:"turnRightArrow"), for: .normal)
        directionsButton?.setImage(UIImage(named:"turnRightArrow"), for: .highlighted)
        directionsButton?.backgroundColor = UIColor.white
        directionsButton?.layer.cornerRadius = 5
        directionsButton?.tintColor = Theme.barTint
        directionsButton?.layer.shadowOffset = CGSize(width: 5, height: 5)
        directionsButton?.layer.shadowColor = UIColor.gray.cgColor
        directionsButton?.addTarget(self, action: #selector(MainEventViewController.calculateDirection), for: .touchUpInside)
        self.view.addSubview(directionsButton)
        directionsButton?.snp.makeConstraints{(make) -> Void in
            make.top.equalTo(self.mapView!.snp.top).offset(8)
            make.height.width.equalTo(35)
            make.right.equalTo(locationButton!.snp.left).offset(-8)
        }
        
        
        let guestButton = UIBarButtonItem(title: "Guests", style: .plain , target: self, action: #selector(MainEventViewController.addGuest))
        guestButton.tintColor = Theme.barTint
        
        let menuButton = UIBarButtonItem(title: "Food Options", style: .plain , target: self, action: #selector(MainEventViewController.addMenu))
        menuButton.tintColor = Theme.barTint

        let cloudButton = UIBarButtonItem(title: "Cloud", style: .plain , target: self, action: #selector(MainEventViewController.addEventCloud))
        menuButton.tintColor = Theme.barTint
        
        toolbar.append(guestButton)
        toolbar.append(UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil))
        toolbar.append(menuButton)
        toolbar.append(UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil))
        toolbar.append(cloudButton)
        
        menuViewController = MenuViewController(style: .plain)
        contactViewController = ContactsViewController(style: .plain)
        cloudEventViewControler = CloudEventViewController()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        AppDelegate.trackInit(value: "MainEventViewController")
        
        UIApplication.shared.applicationIconBadgeNumber = 0
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.navigationBar.topItem?.title = ""
        
        self.navigationController?.setToolbarHidden(false, animated: false)
        self.navigationController?.toolbar.tintColor = Theme.barTint
        self.navigationController?.toolbar.setItems(toolbar, animated: false)
        
        if let name = EventManager.sharedInstance.currentEvent?.name {
            self.nameField?.data = name
        }
        
        if let date = EventManager.sharedInstance.currentEvent?.date {
            timePicker?.date = date as Date
        }
        
        if let place = EventManager.sharedInstance.currentEvent?.place {
            
            if let latitude = place.latitude?.doubleValue, let longitude = place.longitude?.doubleValue {
                if latitude != 0 && longitude != 0 {
                    self.addAnnotation(for: CLLocationCoordinate2D(latitude: latitude, longitude: longitude))
                    let initialLocation = CLLocation(latitude: latitude, longitude: longitude)
                    self.centerMapOnLocation(location: initialLocation)
                }
            }
        }else {
        
            let latitude = Preferences.latitude ?? 0
            let longitude = Preferences.longitude ?? 0
        
            if latitude != 0 && longitude != 0 {
                let initialLocation = CLLocation(latitude: latitude, longitude: longitude)
                self.centerMapOnLocation(location: initialLocation)
            }
            
        }
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        EventManager.sharedInstance.saveContext()
        
        if let event = EventManager.sharedInstance.currentEvent {
            
            if let name = self.nameField?.data , name.characters.count > 0 {
                event.name = name
            }
            
            if let date = self.timePicker?.date {
                event.date = date as NSDate?
            }
            
            EventManager.sharedInstance.saveContext()
        }
        
        AppDelegate.trackExit(value: "MainVIewController")
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func addGuest() {
        self.navigationController?.pushViewController(self.contactViewController!, animated: true)
    }
    
    @objc func addMenu() {
        self.navigationController?.pushViewController(self.menuViewController!, animated: true)
    }
    
    @objc func addEventCloud() {
        self.cloudEventViewControler?.nameLabel.text = EventManager.sharedInstance.currentEvent?.name ?? "No Event"
        self.navigationController?.pushViewController(self.cloudEventViewControler!, animated: true)
    }
}


extension MainEventViewController : MKMapViewDelegate {
    
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                  regionRadius * 2.0, regionRadius * 2.0)
        mapView?.setRegion(coordinateRegion, animated: true)
    }
    
    func updateLocationCity(location: CLLocationCoordinate2D) {
        
        let ceo = CLGeocoder()
        
        ceo.reverseGeocodeLocation(CLLocation(latitude: location.latitude, longitude: location.longitude)) { (placemarks, error) in
            if let placemark = placemarks?[0] {
                
                if let event = EventManager.sharedInstance.currentEvent {
                    
                    var place = event.place
                    if place == nil {
                        place = EventManager.sharedInstance.addPlaceToEvent(event: event)
                    }
                    
                    let locality = placemark.locality ?? ""
                    let country = placemark.country ?? ""
                
                
                    place?.City = locality
                    place?.Country = country
                    
                    place?.latitude = NSNumber(value: location.latitude)
                    place?.longitude = NSNumber(value: location.longitude)
                
                    if let locatedAt = placemark.addressDictionary {
                        if let street = locatedAt["Street"] as? String {
                            place?.Address = street
                        }
                    }
                    
                    
                    let annotation = MKPointAnnotation()
                    
                    
                    annotation.title = "\(country), \(locality)"
                    annotation.subtitle = "\(place?.Address ?? "")"
                    
                    annotation.coordinate = location
                    
                    if let map = self.mapView {
                        map.removeAnnotations(map.annotations)
                    
                        map.addAnnotation(annotation)
                    }
                    
                    EventManager.sharedInstance.saveContext()
                }
            }
            
        }
        
    }

    
    public func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        if (annotation is MKUserLocation) {
            return nil
        }
        
        let identifier = "pin"
        
        var view: MKPinAnnotationView
        
        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
            as? MKPinAnnotationView {
            dequeuedView.annotation = annotation
            view = dequeuedView
        } else {
            view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            view.canShowCallout = true
            view.calloutOffset = CGPoint(x: -5, y: 5)
        }
        return view
    }
    
    public func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(polyline: overlay as! MKPolyline)
        renderer.strokeColor = Theme.barTint
        renderer.lineWidth = 3
        renderer.lineCap = .square
        return renderer
    }
    
    public func addAnnotation(for location: CLLocationCoordinate2D) {
        
        let annotation = MKPointAnnotation()
        annotation.title = "Loading..."
        annotation.coordinate = location
        
        
        if let map = mapView {
            map.removeAnnotations(map.annotations)
            map.addAnnotation(annotation)
            updateLocationCity(location: location)
        }
        
    }

    @objc func tapOnMap(gesture: UITapGestureRecognizer) {
        
        if let map = mapView {
            let location = gesture.location(in: map)
        
            let coordinate = map.convert(location, toCoordinateFrom: map)
            let coord = CLLocationCoordinate2D(latitude: coordinate.latitude, longitude: coordinate.longitude)

        
            addAnnotation(for: coord)
        }
    }
    
    @objc func calculateDirection() {
        
        let request = MKDirectionsRequest()
        
        guard let latitude = EventManager.sharedInstance.currentEvent?.place?.latitude else {
            return
        }
        
        guard let longitude = EventManager.sharedInstance.currentEvent?.place?.longitude else {
            return
        }
        
        guard let sourceCoordinate = self.mapView?.userLocation.coordinate else {
            return
        }
        
        let destCoordinate = CLLocationCoordinate2D(latitude: latitude.doubleValue, longitude: longitude.doubleValue)
        
        request.source = MKMapItem(placemark: MKPlacemark(coordinate: sourceCoordinate, addressDictionary: nil))
        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: destCoordinate, addressDictionary: nil))
        request.requestsAlternateRoutes = true
        request.transportType = .automobile
        
        let directions = MKDirections(request: request)
        
        directions.calculate { [unowned self] response, error in
            guard let unwrappedResponse = response else { return }
            
            for route in unwrappedResponse.routes {
                self.mapView?.add(route.polyline)
                self.mapView?.setVisibleMapRect(route.polyline.boundingMapRect, animated: true)
            }
        }
    }
    
    @objc func useCurrentLocation() {
        
        if let map = self.mapView {
            if map.isUserLocationVisible {
                
                let coordinate = map.userLocation.coordinate
                addAnnotation(for: coordinate)
            }
            
        }
        
    }
}
