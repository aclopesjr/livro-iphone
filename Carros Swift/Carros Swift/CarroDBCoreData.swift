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
        let c = NSEntityDescription.insertNewObject(forEntityName: "Carro", into: context) as! Carro
        return c
    }
    
    class func getContext() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.managedObjectContext
        return context
    }
    
    func getCarrosByType(_ tipo: String) -> Array<Carro> {
        let context = CarroDBCoreData.getContext()
        let entity = NSEntityDescription.entity(forEntityName: "Carro", in: context)
        
        let request = NSFetchRequest<Carro>()
        request.entity = entity
        
        let query = NSPredicate(format: "tipo = \"tipo\"" , argumentArray: nil)
        request.predicate = query
        
        let sortDescriptor = NSSortDescriptor(key: "timestamp", ascending: true)
        let sortDescriptors = [sortDescriptor]
        request.sortDescriptors = sortDescriptors
        
        do {
            let array = try context.fetch(request)
            return array
        } catch {
            print("Erro ao consultar Carros!")
            return [] as Array<Carro>
        }
    }
    
    func save(_ carro: Carro) {
        let context = CarroDBCoreData.getContext()
        
        if (carro.timestamp == nil) {
            carro.timestamp = Date()
        }
        
        do {
            try context.save()
            print("Carro salvo com sucesso!")
        } catch let erro as NSError {
            print("Erro ao salvar: " + erro.localizedDescription)
        }
    }
    
    func delete(_ carro: Carro) {
        let context = CarroDBCoreData.getContext()
        
        context.delete(carro)
        
        do {
            try context.save()
            print("Carro deletado com sucesso!")
        } catch let erro as NSError {
            print("Erro ao deletar: " + erro.localizedDescription)
        }
    }
    
    func deleteCarrosByTipo(_ tipo: String) {
        let carros = getCarrosByType(tipo)
        
        for carro in carros {
            self.delete(carro)
        }
    }
    
    func close() {
        
    }
}
