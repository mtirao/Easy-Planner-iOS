//
//  Invitation.swift
//  
//
//  Created by Marcos Tirao on 4/28/16.
//
//

import Foundation
import CoreData

@objc(Invitation)
class Invitation: NSManagedObject {

    func addText(text:Text) {
        var texts: NSMutableSet
        
        texts = (self.text?.mutableCopy())! as! NSMutableSet
        
        texts.add(text)
    }
    
    func removeText(text1:Text) {
        var texts: NSMutableSet
        
        texts = (self.text?.mutableCopy())! as! NSMutableSet
        
        texts.remove(text1)
    }
    
    func addImage(image: Image) {
        var images: NSMutableSet
        
        images = (self.image?.mutableCopy())! as! NSMutableSet
        images.add(image)
    }
    
    func removeImage(image: Image) {
        var images: NSMutableSet
        
        images = (self.image?.mutableCopy())! as! NSMutableSet
        images.remove(image)
    }

}
