//
//  NSCustomPersistantContainer.swift
//  Qwerty
//
//  Created by Jessi Febria on 07/04/21.
//
import UIKit
import CoreData

class NSCustomPersistentContainer: NSPersistentContainer {
    
    override open class func defaultDirectoryURL() -> URL {
        var storeURL =  FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.SafeType.SafeType")
        storeURL = storeURL?.appendingPathComponent("Library", isDirectory: true)
        storeURL = storeURL?.appendingPathComponent("Caches", isDirectory: true)
        
        storeURL = storeURL?.appendingPathComponent("SafeType.sqlite")

        return storeURL!
    }

}
