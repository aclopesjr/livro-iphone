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
        let path = NSBundle.mainBundle().pathForResource("carros_" + tipo, ofType: "xml")!
        let data = NSData(contentsOfFile: path)!
        //let carros = parserXML_SAX(data)
        let carros = parserXML_DOM(data)
        return carros
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
 }
