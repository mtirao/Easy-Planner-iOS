//
//  Event.swift
//  
//
//  Created by Marcos Tirao on 4/28/16.
//
//

import Foundation
import CoreData

@objc(Event)
class Event: NSManagedObject {

    func addContact(contact:Contact) {
        var contacts: NSMutableSet
        
        contacts = self.mutableSetValue(forKey:"contact")
        contacts.add(contact)
        
    }
    
    func removeContact(contact: Contact) {
        var contacts: NSMutableSet
        
        contacts = self.mutableSetValue(forKey:"contact")
        contacts.remove(contact)
    }
    
    func addSong(song:Music) {
        var songs: NSMutableSet
        
        songs = self.mutableSetValue(forKey:"music")
        songs.add(song)
        
    }
    
    func removeSong(song: Music) {
        var songs: NSMutableSet
        
        songs = self.mutableSetValue(forKey:"music")
        songs.remove(song)
    }

    func addMenu(menu:Menu) {
        var menus: NSMutableSet
        
        menus = self.mutableSetValue(forKey:"food")
        menus.add(menu)
    }
    
    func removeMenu(menu: Menu) {
        var menus: NSMutableSet
        
        menus = self.mutableSetValue(forKey:"food")
        menus.remove(menu)
    }
    
    func addMisc(misc:Misc) {
        var miscs: NSMutableSet
        
        miscs = self.mutableSetValue(forKey:"misc")
        miscs.add(misc)
    }
    
    func removeMisc(misc: Misc) {
        var miscs: NSMutableSet
        
        miscs = self.mutableSetValue(forKey:"misc")
        miscs.remove(misc)
    }
    
    func addEventMisc(misc:EventMisc) {
        var miscs: NSMutableSet
        
        miscs = self.mutableSetValue(forKey: "extras")
        miscs.add(misc)
    }
    
    func removeEventMisc(misc: EventMisc) {
        var miscs: NSMutableSet
        
        miscs = self.mutableSetValue(forKey: "extras")
        miscs.remove(misc)
    }

    func addTable(table: Tables) {
        var tables: NSMutableSet
        
        tables = self.mutableSetValue(forKey:"tables")
        tables.add(table)
    }
    
    func removeTable(table: Tables) {
        var miscs: NSMutableSet
        
        miscs = self.mutableSetValue(forKey:"tables")
        miscs.remove(table)
    }

}
