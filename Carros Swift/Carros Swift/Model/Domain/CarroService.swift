//
//  CarroService.swift
//  Carros Swift
//
//  Created by Antonio Lopes on 8/4/16.
//  Copyright © 2016 Antonio Lopes. All rights reserved.
//

import UIKit

class CarroService {
    class func getCarros() -> Array<Carro> {
        var carros : Array<Carro> = []
        for index in 1...10 {
            let newCarro = Carro()
            newCarro.nome = "Ferrari " + String(index)
            newCarro.desc = "Desc Ferrari " + String(index)
            newCarro.url_foto = "ferrari_ff.png"
            
            carros.append(newCarro)
        }
        
        return carros
    }
    
    class func getCarroByTypeFromFile(tipo: String) -> Array<Carro> {
        //let path = NSBundle.mainBundle().pathForResource("carros_" + tipo, ofType: "xml")!
        let path = NSBundle.mainBundle().pathForResource("carros_" + tipo, ofType: "json")!
        let data = NSData(contentsOfFile: path)!
        //return parserXML_SAX(data)
        //return parserXML_DOM(data)
        return parserJSON(data)
    }
    
    class func parserXML_SAX(data: NSData) -> Array<Carro> {
        if data.length == 0 {
            return []
        }
        
        let xmlParser = NSXMLParser(data: data)
        let carrosParser = XMLCarroParser()
        xmlParser.delegate = carrosParser
        
        if xmlParser.parse() {
            return carrosParser.carros
        }
        
        return []
    }
    
    class func getCarrosByTipo(tipo: String, withCache: Bool, andCallback: (carros:Array<Carro>, error:NSError!) -> Void) {
        
        var db = CarroDB()
        let carros = withCache ? db.getCarrosByType(tipo) : []
        db.close()
        
        if (carros.count > 0) {
            andCallback(carros: carros, error: nil)
            return
        }
        
        let http = NSURLSession.sharedSession()
        let url = NSURL(string: "http://www.livroiphone.com.br/carros/carros_" + tipo + ".json")!
        let task = http.dataTaskWithURL(url, completionHandler: {
            (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
            if error != nil {
                andCallback(carros:[], error: error!)
            } else {
                let carros = CarroService.parserJSON(data!)
                
                if carros.count > 0 {
                    db = CarroDB()
                    db.deleteCarrosByTipo(tipo)
                    for carro in carros {
                        carro.tipo = tipo
                        db.save(carro)
                    }
                    db.close()
                }
                
                dispatch_sync(dispatch_get_main_queue(), {
                    andCallback(carros: carros, error: nil)
                })
            }
        })
        task.resume()
    }
    
    class func parserXML_DOM(data: NSData) -> Array<Carro> {
        if data.length == 0 {
            return [];
        }
        
        var carros : Array<Carro> = []
        
        let document = try? SMXMLDocument(data: data)
        if document == nil {
            return carros
        }
        
        let root = document!.root as SMXMLElement
        let tagCarros = root.childrenNamed("carro") as NSArray
        
        for x:AnyObject in tagCarros {
            let xml = x as! SMXMLElement
            let carro = Carro()
            carro.nome = xml.valueWithPath("nome")
            carro.desc = xml.valueWithPath("desc")
            carro.url_info = xml.valueWithPath("url_info")
            carro.url_foto = xml.valueWithPath("url_foto")
            carro.url_video = xml.valueWithPath("url_video")
            if (xml.valueWithPath("longitude") != nil) {
                carro.longitude = xml.valueWithPath("longitude")
            }
            if (xml.valueWithPath("latitude") != nil) {
                carro.latitude = xml.valueWithPath("latitude")
            }
            carros.append(carro)
        }
        
        return carros
    }
    
    class func parserJSON(data: NSData) -> Array<Carro> {
        if data.length == 0 {
            return []
        }
        
        var carros : Array<Carro> = []
        let dicOp = try? NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
        if let dict = dicOp {
            let jsoCarros : NSDictionary = dict["carros"] as! NSDictionary
            let arrayCarros: NSArray = jsoCarros["carro"] as! NSArray
            
            for obj:AnyObject in arrayCarros {
                let dict = obj as! NSDictionary
                let carro = Carro()
                carro.nome = dict["nome"] as! String
                carro.desc = dict["desc"] as! String
                carro.url_info = dict["url_info"] as! String
                carro.url_foto = dict["url_foto"] as! String
                carro.url_video = dict["url_video"] as! String
                carro.longitude = dict["longitude"] as! String
                carro.latitude = dict["latitude"] as! String
                carros.append(carro)
            }
        }
        return carros
    }
 }
