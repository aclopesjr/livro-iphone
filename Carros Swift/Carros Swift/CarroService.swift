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
        let carros = parserXML_SAX(data)
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
 }
