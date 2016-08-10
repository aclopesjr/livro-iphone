//
//  Prefs.swift
//  Carros Swift
//
//  Created by Antonio Lopes on 8/10/16.
//  Copyright © 2016 Antonio Lopes. All rights reserved.
//

import UIKit

class Prefs: NSObject {
    
    class func setObjectForKey(valor: NSObject, chave: String) {
        let prefs = NSUserDefaults.standardUserDefaults()
        prefs.setObject(valor, forKey: chave)
        prefs.synchronize()
    }
    
    class func getObjectForKey(chave: String) -> AnyObject! {
        let prefs = NSUserDefaults.standardUserDefaults()
        return prefs.objectForKey(chave)
    }
}
