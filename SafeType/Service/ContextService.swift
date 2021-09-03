//
//  ContextService.swift
//  Qwerty
//
//  Created by Jessi Febria on 08/04/21.
//

import CoreData
import UIKit

class ContextService {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func deleteHistory(_ history : Historys) {
        context.delete(history)
        saveChanges()
    }
    
    func deleteKataKotor(_ kataKotor : KataKotors) {
        context.delete(kataKotor)
        saveChanges()
    }
    
    func loadHistory(_ request : NSFetchRequest<Historys>) -> [Historys]{
        do {
            request.sortDescriptors = [NSSortDescriptor(key: "waktu", ascending: false)]
            return try context.fetch(request)
        } catch  {
            print("fail load item")
        }
        return []
    }
    
    func loadKataKotor(_ request : NSFetchRequest<KataKotors>) -> [KataKotors]{
        do {
            return try context.fetch(request)
        } catch  {
            print("fail load item")
        }
        return []
    }
    
    func loadKeyboardSetting(_ request : NSFetchRequest<Keyboards>) -> [Keyboards]{
        do {
            return try context.fetch(request)
        } catch  {
            print("fail load item")
        }
        return []
    }
    
    func saveChanges(){
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