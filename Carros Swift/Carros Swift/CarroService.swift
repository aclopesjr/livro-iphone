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
}
