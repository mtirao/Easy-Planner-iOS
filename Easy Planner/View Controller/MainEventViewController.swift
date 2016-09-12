//
//  MainEventViewController.swift
//  Easy Planner
//
//  Created by Marcos Tirao on 8/31/16.
//  Copyright © 2016 Marcos Tirao. All rights reserved.
//

import UIKit
import MapKit

let contactViewControllerIdentifier = "contactsViewController"

let eventNamePlaceHolder = "NewEvent"

let eventDateSegue = "eventDateSegue"
let eventNameSegue = "eventNameSegue"

let regionRadius: CLLocationDistance = 1000

class MainEventViewController: UIViewController {
    
    var contactViewController: ContactsViewController?

    var eventDate : FieldViewController?
    var eventName : FieldViewController?
    
    @IBOutlet weak var mapView : MKMapView!
    @IBOutlet weak var timePicker : UIDatePicker!
    @IBOutlet weak var locationButton : UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Contacts", style: .plain, target: self, action: #selector(MainEventViewController.contactAction))
        
        locationButton?.backgroundColor = UIColor.white
        locationButton?.layer.cornerRadius = 5
        locationButton?.tintColor = UIColor.blue
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.navigationBar.topItem?.title = ""
        
        if let name = EventManager.sharedInstance.currentEvent?.name {
            
            if name != eventNamePlaceHolder {
                self.eventName?.editText.text = name
            }
            
        }
        
        if let date = EventManager.sharedInstance.currentEvent?.date {
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .short
            
            eventDate?.staticText.text = dateFormatter.string(from: date as Date)
            timePicker.date = date as Date
            
        }
        
        
        
        let latitude = Preferences.latitude ?? 0
        let longitude = Preferences.longitude ?? 0
        
        if latitude != 0 && longitude != 0 {
            let initialLocation = CLLocation(latitude: latitude, longitude: longitude)
            self.centerMapOnLocation(location: initialLocation)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        EventManager.sharedInstance.saveContext()
        
        if let event = EventManager.sharedInstance.currentEvent {
            
            if let name = eventName?.editText.text , name.characters.count > 0 {
                event.name = name
                EventManager.sharedInstance.saveContext()
            }
            
            if let date = self.timePicker?.date {
                event.date = date as NSDate?
            }
        }
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == eventDateSegue {
            self.eventDate = segue.destination as? FieldViewController
        }else if segue.identifier == eventNameSegue {
            self.eventName = segue.destination as? FieldViewController
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}

//MARK: - Action Methods
extension MainEventViewController {
    
    func contactAction() {
        
        if contactViewController == nil {
            self.contactViewController = self.storyboard?.instantiateViewController(withIdentifier: contactViewControllerIdentifier) as? ContactsViewController
        }
        
        if let contact = self.contactViewController {
            self.navigationController?.pushViewController(contact, animated: true)
        }
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

    @IBAction func tapOnMap(gesture: UITapGestureRecognizer) {
        
        
        if let map = mapView {
            let location = gesture.location(in: map)
        
            let coordinate = map.convert(location, toCoordinateFrom: map)
            let coord = CLLocationCoordinate2D(latitude: coordinate.latitude, longitude: coordinate.longitude)

        
            addAnnotation(for: coord)
        }
    }
    
    @IBAction func useCurrentLocation(sender: Any?) {
        
        if let map = self.mapView {
            if map.isUserLocationVisible {
                
                let coordinate = map.userLocation.coordinate
                addAnnotation(for: coordinate)
            }
            
        }
        
    }
}
