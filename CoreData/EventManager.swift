//
//  EventManager.swift
//  EasyPlanner
//
//  Created by Marcos Tirao on 4/28/16.
//  Copyright © 2016 Marcos Tirao. All rights reserved.
//

import UIKit
import CoreData

@objc class EventManager: NSObject {
    
    static let sharedInstance = EventManager()
    private var managedObject : NSManagedObjectContext
    
    var currentEvent : Event?
    
    var nextEvents : [Event] = [Event]()
    
    private override init() {
        managedObject = DataController.defaultController.managedObjectContext
        
        super.init()
        _ = self.eventsForDate(firstDate: NSDate())
    }
  
    //MARK: - Event Management
    func createEvent(forDate: Date) {
        
        let event : Event = NSEntityDescription.insertNewObject(forEntityName: "Event", into: self.managedObject) as! Event
        
        event.name = "NewEvent"
        event.id =  NSNumber(value: NSDate().timeIntervalSince1970)
        event.date = forDate as NSDate?
        
        self.currentEvent = event
        
        self.saveContext()
    }
    
    func deleteCurrentEvent() {
        if let event = self.currentEvent {
            deleteEvent(event: event)
            self.currentEvent = nil
        }
    }
    
    func deleteEvent(event: Event) {
        
        let contacts = event.contact!.allObjects
        for idx in 0..<contacts.count {
            removeContactFromEvent(event: event, contact: contacts[idx] as! Contact)
        }
        
        self.managedObject.delete(event)
        
        self.saveContext()
        
    }
    
    func eventsForDate(firstDate: NSDate, lastDate:NSDate) -> [Event] {
        
        let fetchRequest : NSFetchRequest<Event> = NSFetchRequest(entityName: "Event")
        fetchRequest.predicate = NSPredicate(format: "(date >= %@) AND (date<= %@)", firstDate, lastDate)
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
        
        do {
            let events = try self.managedObject.fetch(fetchRequest)
            return events
        }catch {
            NSLog("Error in fetch request")
        }
        
        return []
        
    }
    
    func eventsForDate(firstDate: NSDate) -> [Event] {
        
        let fetchRequest =  NSFetchRequest<Event>(entityName: "Event")
        fetchRequest.predicate = NSPredicate(format: "(date >= %@)", firstDate)
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
        
        do {
            let events = try self.managedObject.fetch(fetchRequest)
            self.nextEvents = events
            
            NotificationCenter.default.post(name: NSNotification.Name("updatenextevent"), object: nil, userInfo: nil)
            
            return events
        }catch {
            NSLog("Error in fetch request")
        }
        
        return []
        
    }

    
    //MARK: - Contact Management for a given event
    func addContactToEvent(event:Event) -> Contact {
        
        let contact : Contact = NSEntityDescription.insertNewObject(forEntityName: "Contact", into: self.managedObject) as! Contact
        event.addContact(contact: contact)
        contact.event = event
        
        return contact
    }
    
    func removeContactFromEvent(event:Event, contact:Contact) {
        event.removeContact(contact: contact)
        contact.event = nil
        self.managedObject.delete(contact)
        
        
        self.saveContext()
    }
    
    func contactsForEvent(event: Event) -> [Contact] {
        let fetchRequest : NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Contact")
        fetchRequest.predicate = NSPredicate(format: "event.id == %ld", (event.id?.int64Value)!)
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        
        do {
            guard let contacts = try self.managedObject.fetch(fetchRequest) as? [Contact] else {
                return []
            }
            return contacts
        }catch {
            NSLog("Error in fetch request")
        }
        
        return []
    }
    
    //MARK: - Place Management for a given event
    func addPlaceToEvent(event:Event) -> Place {
        
        let place : Place = NSEntityDescription.insertNewObject(forEntityName: "Place", into: self.managedObject) as! Place
        
        place.Address = ""
        place.City = ""
        place.Country = ""
        place.Name = ""
        place.price = NSDecimalNumber(value: 0.0)
        place.priceGroup = NSNumber(value: true)
        event.place = place
        
        var events: NSMutableSet
        
        events = place.mutableSetValue(forKey: "Event")
        events.add(event)
        
        self.saveContext()
        return place
        
    }
    
    //MARK: - Music Management for a given event
    func addSongToEvent(event:Event) -> Music {
        
        let song : Music = NSEntityDescription.insertNewObject(forEntityName: "Music", into: self.managedObject) as! Music
        event.addSong(song: song)
        song.addEvent(event: event)
        
        return song
    }
    
    func removeSongFromEvent(event:Event, song:Music) {
        event.removeSong(song: song)
        song.removeEvent(event: event)
        self.managedObject.delete(song)
        
        
        self.saveContext()
    }
    
    func songForEvent(event: Event) -> [Music] {
        
        let fetchRequest = NSFetchRequest<Music>(entityName: "Music")
        fetchRequest.predicate = NSPredicate(format: "%@ IN event", event)
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        
        do {
            let songs = try self.managedObject.fetch(fetchRequest)
            return songs
        }catch {
            NSLog("Error in fetch request")
        }
        
        return []
    }

    //MARK: - Menu Management for a given event
    func addMenuToEvent(event:Event) -> Menu {
        
        let menu : Menu = NSEntityDescription.insertNewObject(forEntityName: "Menu", into: self.managedObject) as! Menu
        event.addMenu(menu: menu)
        menu.event = event
        
        return menu
    }
    
    func removeMenuFromEvent(event:Event, menu:Menu) {
        event.removeMenu(menu: menu)
        self.managedObject.delete(menu)
        
        
        self.saveContext()
    }
    
    func menuForEvent(event: Event) -> [Menu] {
        let fetchRequest = NSFetchRequest<Menu>(entityName: "Menu")
        fetchRequest.predicate = NSPredicate(format: "event.id == %ld", (event.id?.int64Value)!)
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "menuname", ascending: true)]
        
        do {
            let menus = try self.managedObject.fetch(fetchRequest)            
            return menus
        }catch {
            NSLog("Error in fetch request")
        }
        
        return []
    }

    //MARK: - Menu option Management for a given event
    func addOptionToMenu(menu:Menu) -> Option {
        
        let option : Option = NSEntityDescription.insertNewObject(forEntityName: "Option", into: self.managedObject) as! Option
        menu.addOption(option: option)
        option.menu = menu
        
        return option
    }
    
    func removeOptionFromEvent(menu:Menu, option:Option) {
        
        menu.removeOption(option: option)
        self.managedObject.delete(option)
        
        
        self.saveContext()
    }
    
    func optionForMenu(menu: Menu) -> [Option] {
        let fetchRequest = NSFetchRequest<Option>(entityName: "Option")
        fetchRequest.predicate = NSPredicate(format: "menu == %@", menu)
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "type", ascending: true)]
        
        do {
            let options = try self.managedObject.fetch(fetchRequest)
            return options
        }catch {
            NSLog("Error in fetch request")
        }
        
        return []
    }
    
    //MARK: - Misc Management for a given event
    func addMiscToEvent(event:Event) -> Misc {
        
        let misc : Misc = NSEntityDescription.insertNewObject(forEntityName: "Misc", into: self.managedObject) as! Misc
        event.addMisc(misc: misc)
        misc.event = event
        
        return misc
    }
    
    func removeMiscFromEvent(event:Event, misc:Misc) {
        event.removeMisc(misc: misc)
        self.managedObject.delete(misc)
        
        
        self.saveContext()
    }
    
    func miscForEvent(event: Event) -> [Misc] {
        let fetchRequest = NSFetchRequest<Misc>(entityName: "Misc")
        fetchRequest.predicate = NSPredicate(format: "event.id == %ld", (event.id?.int64Value)!)
        
        do {
            let miscs = try self.managedObject.fetch(fetchRequest)
            return miscs
        }catch {
            NSLog("Error in fetch request")
        }
        
        return []
    }
    
    //MARK: - Event Misc Management for a given event
    func addEventMiscToEvent(event:Event) -> EventMisc {
        
        let misc : EventMisc = NSEntityDescription.insertNewObject(forEntityName: "EventMisc", into: self.managedObject) as! EventMisc
        event.addEventMisc(misc: misc)
        misc.addEvent(event: event)
        
        return misc
    }
    
    func removeEventMiscFromEvent(event:Event, misc:Misc) {
        event.removeMisc(misc: misc)
        self.managedObject.delete(misc)
        
        
        self.saveContext()
    }
    
    func eventMiscForEvent(event: Event) -> [EventMisc] {
        let fetchRequest = NSFetchRequest<EventMisc>(entityName: "EventMisc")
        fetchRequest.predicate = NSPredicate(format: "%@ IN event", event)
    
        do {
            let miscs = try self.managedObject.fetch(fetchRequest)
            return miscs
        }catch {
            NSLog("Error in fetch request")
        }
        
        return []
    }
    
    //MARK: - Table Management for a given event
    func addTableToEvent(event:Event) -> Tables {
        
        let table: Tables = NSEntityDescription.insertNewObject(forEntityName: "Tables", into: self.managedObject) as! Tables
        event.addTable(table: table)
        table.event = event
        
        return table
    }
    
    func removeTablesFromEvent(event:Event, table: Tables) {
        event.removeTable(table: table)
        self.managedObject.delete(table)
        
        
        self.saveContext()
    }
    
    func tablesForEvent(event: Event) -> [Tables] {
        let fetchRequest = NSFetchRequest<Tables>(entityName: "Tables")
        fetchRequest.predicate = NSPredicate(format: "event.id == %ld", (event.id?.int64Value)!)
        
        do {
            let tables = try self.managedObject.fetch(fetchRequest)
            return tables
        }catch {
            NSLog("Error in fetch request")
        }
        
        return []
    }

    //MARK: - Invitation Management for a given event
    func addInvitationToEvent(event:Event) -> Invitation {
        
        guard let invitation = event.invitation else {
            let invitation: Invitation = NSEntityDescription.insertNewObject(forEntityName: "Invitation", into: self.managedObject) as! Invitation
            event.invitation = invitation
            invitation.event = event
            
            self.saveContext()
            return invitation
        }
        
        return invitation
        
    }
    
    func removeInvitationFromEvent(event:Event, invitation: Invitation) {
        event.invitation = nil
        self.managedObject.delete(invitation)
        
        self.saveContext()
    }
    
    func invitationForEvent(event: Event) -> [Invitation] {
        let fetchRequest = NSFetchRequest<Invitation>(entityName: "Invitation")
        fetchRequest.predicate = NSPredicate(format: "event.id == %ld", (event.id?.int64Value)!)
        
        do {
            let invitation = try self.managedObject.fetch(fetchRequest)
            return invitation
        }catch {
            NSLog("Error in fetch request")
        }
        
        return []
    }

    //MARK: - Text Management for a given invitation
    func addTextToInvitation(invitation:Invitation) -> Text {
        
        let text: Text = NSEntityDescription.insertNewObject(forEntityName: "Text", into: self.managedObject) as! Text
        invitation.addText(text: text)
        text.invitation = invitation
        
        return text
        
    }
    
    func removeTextFromInvitation(invitation: Invitation, text: Text) {
        invitation.removeText(text1: text)
        self.managedObject.delete(text)
        
        self.saveContext()
    }
    
    func textForInvitation(invitation: Invitation) -> [Text] {
        let fetchRequest = NSFetchRequest<Text>(entityName: "Text")
        fetchRequest.predicate = NSPredicate(format: "invitation == %@", invitation)
        
        do {
            let text = try self.managedObject.fetch(fetchRequest)            
            return text
        }catch {
            NSLog("Error in fetch request")
        }
        
        return []
    }

    //MARK: - Image Management for a given invitation
    func addImageToInvitation(invitation:Invitation) -> Image {
        
        let image: Image = NSEntityDescription.insertNewObject(forEntityName: "Image", into: self.managedObject) as! Image
        invitation.addImage(image: image)
        image.invitation = invitation
        
        return image
        
    }
    
    func removeImageFromInvitation(invitation: Invitation, image: Image) {
        invitation.removeImage(image: image)
        self.managedObject.delete(image)
        
        self.saveContext()
    }
    
    func imageForInvitation(invitation: Invitation) -> [Image] {
        let fetchRequest : NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Image")
        fetchRequest.predicate = NSPredicate(format: "invitation == %@", invitation)
        
        do {
            guard let image = try self.managedObject.fetch(fetchRequest) as? [Image] else {
                return []
            }
            
            return image
        }catch {
            NSLog("Error in fetch request")
        }
        
        return []
    }


    //MARK: - Persist data
    func saveContext() {
            DataController.defaultController.saveContext()
        
    }
    
}
