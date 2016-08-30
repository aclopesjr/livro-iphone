//
//  CarroDBCoreData.swift
//  Carros Swift
//
//  Created by Antonio Lopes on 8/30/16.
//  Copyright © 2016 Antonio Lopes. All rights reserved.
//

import Foundation
import CoreData

class CarroDBCoreData {
    
    class func newInstance () -> Carro {
        let context = getContext()
        let c = NSEntityDescription.insertNewObjectForEntityForName("Carro", inManagedObjectContext: context) as! Carro
        return c
    }
    
    class func getContext() -> NSManagedObjectContext {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context = appDelegate.managedObjectContext
        return context
    }
    
    func getCarrosByType(tipo: String) -> Array<Carro> {
        let context = CarroDBCoreData.getContext()
        let entity = NSEntityDescription.entityForName("Carro", inManagedObjectContext: context)
        
        let request = NSFetchRequest()
        request.entity = entity
        
        let query = NSPredicate(format: "tipo = \"tipo\"" , argumentArray: nil)
        request.predicate = query
        
        let sortDescriptor = NSSortDescriptor(key: "timestamp", ascending: true)
        let sortDescriptors = [sortDescriptor]
        request.sortDescriptors = sortDescriptors
        
        do {
            let array = try context.executeFetchRequest(request)
            return array as! Array<Carro>
        } catch {
            print("Erro ao consultar Carros!")
            return [] as Array<Carro>
        }
    }
    
    func save(carro: Carro) {
        let context = CarroDBCoreData.getContext()
        
        if (carro.timestamp == nil) {
            carro.timestamp = NSDate()
        }
        
        do {
            try context.save()
            print("Carro salvo com sucesso!")
        } catch let erro as NSError {
            print("Erro ao salvar: " + erro.localizedDescription)
        }
    }
    
    func delete(carro: Carro) {
        let context = CarroDBCoreData.getContext()
        
        context.deleteObject(carro)
        
        do {
            try context.save()
            print("Carro deletado com sucesso!")
        } catch let erro as NSError {
            print("Erro ao deletar: " + erro.localizedDescription)
        }
    }
    
    func deleteCarrosByTipo(tipo: String) {
        let carros = getCarrosByType(tipo)
        
        for carro in carros {
            self.delete(carro)
        }
    }
    
    func close() {
        
    }
}