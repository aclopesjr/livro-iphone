//
//  Alerta.swift
//  Carros Swift
//
//  Created by Antonio Lopes on 8/4/16.
//  Copyright © 2016 Antonio Lopes. All rights reserved.
//

import UIKit

class Alerta {
    
    class func alerta(_ message: String, viewController: UIViewController) {
        let alert = UIAlertController(title: "Alerta", message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        
        viewController.present(alert, animated: true, completion: nil)
    }
}
