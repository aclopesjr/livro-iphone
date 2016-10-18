//
//  Prefs.swift
//  Carros Swift
//
//  Created by Antonio Lopes on 8/10/16.
//  Copyright © 2016 Antonio Lopes. All rights reserved.
//

import UIKit

class Prefs: NSObject {
    
    class func setObjectForKey(_ valor: NSObject, chave: String) {
        let prefs = UserDefaults.standard
        prefs.set(valor, forKey: chave)
        prefs.synchronize()
    }
    
    class func getObjectForKey(_ chave: String) -> AnyObject! {
        let prefs = UserDefaults.standard
        return prefs.object(forKey: chave) as AnyObject!
    }
}
