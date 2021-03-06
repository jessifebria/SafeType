//
//  KeyboardDataController.swift
//  QwertyKeyboard
//
//  Created by Jessi Febria on 07/04/21.
//

import Foundation
import CoreData
import UIKit

final class KeyboardDataController {
    
    // MARK: - Core Data Setting
   lazy var persistentContainer: NSPersistentContainer = {
       let container = NSCustomPersistentContainer(name: "SafeType")
       
       container.loadPersistentStores(completionHandler: { (storeDescription, error) in
           if let error = error as NSError? {
               fatalError("Unresolved error \(error), \(error.userInfo)")
           }
       })
       return container
   }()
    
    //MARK: Controller
    
    func getContext() -> NSManagedObjectContext {
        return self.persistentContainer.viewContext
    }
    
    func isKataKotor(_ kata : String) -> Bool {
        
        let context = getContext()
        let request : NSFetchRequest<KataKotor> = KataKotor.fetchRequest()
        var rowCount = 0
        request.predicate = NSPredicate(format: "kata MATCHES[cd] %@", kata)
        
        do {
           rowCount = try context.count(for: request)
        } catch  {
            print("Error checking row count \(error)")
        }
        
        if rowCount > 0 {
            do {
                /**
                 If kataKotor found, it will increment the num of kataKotor detected.
                 */
                let kataKotor = try context.fetch(request)[0]
                let newTotal = kataKotor.total + 1
                
                kataKotor.setValue(newTotal, forKey: "total")
                saveChanges(context)
            } catch  {
                print("Error update total in KataKotor \(error)")
            }
        }
        
        return rowCount == 0 ? false : true
    }
    

    func saveHistory (kalimat : String, kataKotor : String, platform : String) {
        let context = getContext()
        let newHistory = History(context: context)
        
        newHistory.kalimat = kalimat
        newHistory.kataKotor = kataKotor
        newHistory.platform = platform
        newHistory.waktu = Date()
        
        saveChanges(context)
    }
    
    func saveKeyboardSetting(_ isFullAccess : Bool){
        let context = getContext()
        let request : NSFetchRequest<Keyboard> = Keyboard.fetchRequest()
        
        var keyboards = [Keyboard]()
        
        do {
            try keyboards = context.fetch(request)
        } catch  {
            print("fail load item")
        }
        
        for keyboard in keyboards{
            context.delete(keyboard)
        }
        
        let keyboardSetting = Keyboard(context: context)
        keyboardSetting.isFullAccess = isFullAccess
        keyboardSetting.lastSeen = Date()
        
        saveChanges(context)
    }
    
    
    func saveChanges(_ context : NSManagedObjectContext){
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
}
