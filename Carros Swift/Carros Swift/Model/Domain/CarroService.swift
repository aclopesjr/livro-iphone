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
            let newCarro = CarroDBCoreData.newInstance()
            newCarro.nome = "Ferrari " + String(index)
            newCarro.desc = "Desc Ferrari " + String(index)
            newCarro.url_foto = "ferrari_ff.png"
            
            carros.append(newCarro)
        }
        
        return carros
    }
    
    class func getCarroByTypeFromFile(_ tipo: String) -> Array<Carro> {
        //let path = NSBundle.mainBundle().pathForResource("carros_" + tipo, ofType: "xml")!
        let path = Bundle.main.path(forResource: "carros_" + tipo, ofType: "json")!
        let data = try! Data(contentsOf: URL(fileURLWithPath: path))
        //return parserXML_SAX(data)
        //return parserXML_DOM(data)
        return parserJSON(data)
    }
    
    class func parserXML_SAX(_ data: Data) -> Array<Carro> {
        if data.count == 0 {
            return []
        }
        
        let xmlParser = XMLParser(data: data)
        let carrosParser = XMLCarroParser()
        xmlParser.delegate = carrosParser
        
        if xmlParser.parse() {
            return carrosParser.carros
        }
        
        return []
    }
    
    class func getCarrosByTipo(_ tipo: String, withCache: Bool, andCallback: @escaping (_ carros:Array<Carro>, _ error:NSError?) -> Void) {
        
        var db = CarroDBCoreData()
        let carros = withCache ? db.getCarrosByType(tipo) : []
        db.close()
        
        if (carros.count > 0) {
            andCallback(carros, nil)
            return
        }
        
        let http = URLSession.shared
        let url = URL(string: "http://www.livroiphone.com.br/carros/carros_" + tipo + ".json")!
        
        let task = http.dataTask(with: url, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) in
            if error != nil {
                andCallback([], error! as NSError?)
            } else {
                let carros = CarroService.parserJSON(data!)
                
                if carros.count > 0 {
                    db = CarroDBCoreData()
                    db.deleteCarrosByTipo(tipo)
                    for carro in carros {
                        carro.tipo = tipo
                        db.save(carro)
                    }
                    db.close()
                }
                
                DispatchQueue.main.sync(execute: {
                    andCallback(carros, nil)
                })
            }
        })
        
//        let task = http.dataTask(with: url, completionHandler: {
//            (data: Data?, response: URLResponse?, error: NSError?) -> Void in
//            if error != nil {
//                andCallback([], error!)
//            } else {
//                let carros = CarroService.parserJSON(data!)
//                
//                if carros.count > 0 {
//                    db = CarroDBCoreData()
//                    db.deleteCarrosByTipo(tipo)
//                    for carro in carros {
//                        carro.tipo = tipo
//                        db.save(carro)
//                    }
//                    db.close()
//                }
//                
//                DispatchQueue.main.sync(execute: {
//                    andCallback(carros, nil)
//                })
//            }
//        } as! (Data?, URLResponse?, Error?) -> Void)
        task.resume()
    }
    
    class func parserXML_DOM(_ data: Data) -> Array<Carro> {
        if data.count == 0 {
            return [];
        }
        
        var carros : Array<Carro> = []
        
        let document = try? SMXMLDocument(data: data)
        if document == nil {
            return carros
        }
        
        let root = document!.root as SMXMLElement
        let tagCarros = root.childrenNamed("carro") as NSArray
        
        
        for x in tagCarros {
            let xml = x as! SMXMLElement
            let carro = CarroDBCoreData.newInstance()
            carro.nome = xml.value(withPath: "nome")
            carro.desc = xml.value(withPath: "desc")
            carro.url_info = xml.value(withPath: "url_info")
            carro.url_foto = xml.value(withPath: "url_foto")
            carro.url_video = xml.value(withPath: "url_video")
            if (xml.value(withPath: "longitude") != nil) {
                carro.longitude = xml.value(withPath: "longitude")
            }
            if (xml.value(withPath: "latitude") != nil) {
                carro.latitude = xml.value(withPath: "latitude")
            }
            carros.append(carro)
        }
        
        return carros
    }
    
    class func parserJSON(_ data: Data) -> Array<Carro> {
        if data.count == 0 {
            return []
        }
        
        var carros : Array<Carro> = []
        let dicOp = try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
        if let dict = dicOp {
            let jsoCarros : NSDictionary = dict["carros"] as! NSDictionary
            let arrayCarros: NSArray = jsoCarros["carro"] as! NSArray
            
            for obj in arrayCarros {
                let dict = obj as! NSDictionary
                let carro = CarroDBCoreData.newInstance()
                carro.nome = dict["nome"] as? String
                carro.desc = dict["desc"] as? String
                carro.url_info = dict["url_info"] as? String
                carro.url_foto = dict["url_foto"] as? String
                carro.url_video = dict["url_video"] as? String
                carro.longitude = dict["longitude"] as? String
                carro.latitude = dict["latitude"] as? String
                carros.append(carro)
            }
        }
        return carros
    }
 }
