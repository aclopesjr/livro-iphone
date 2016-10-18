//
//  XMLCarroParser.swift
//  Carros Swift
//
//  Created by Antonio Lopes on 8/5/16.
//  Copyright © 2016 Antonio Lopes. All rights reserved.
//

import UIKit

class XMLCarroParser: NSObject, XMLParserDelegate {
    // MARK: Variable
    var carros : Array<Carro> = []
    var tempString : String = ""
    var carro : Carro?
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        if "carro" == elementName {
            // tag <carro> encontrada
            self.carro = CarroDBCoreData.newInstance()
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if "carros" == elementName {
            // tag de fim </carros>
            return
        }
        
        if "carro" == elementName {
            self.carros.append(carro!)
            self.carro = nil
            return
        }
        
        if carro != nil {
            if "nome" == elementName {
                self.carro!.nome = tempString
            } else if "desc" == elementName {
                self.carro!.desc = tempString
            } else if "url_foto" == elementName {
                self.carro!.url_foto = tempString
            } else if "url_info" == elementName {
                self.carro!.url_info = tempString
            } else if "url_video" == elementName {
                self.carro!.url_video = tempString
            } else if "latitude" == elementName {
                self.carro!.latitude = tempString
            } else if "longitude" == elementName {
                self.carro!.longitude = tempString
            }
            tempString = ""
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        tempString += string.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
}
