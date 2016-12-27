//
//  Utils.swift
//  Carros Swift
//
//  Created by Antonio Lopes on 12/27/16.
//  Copyright © 2016 Antonio Lopes. All rights reserved.
//

import UIKit

class Utils {

    class func isIphone() -> Bool {
        let iPhone = UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.phone
        return iPhone
    }
    
    class func isIpad() -> Bool {
        let iPad = UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad
        return iPad
    }
    
    class func isLandscape() -> Bool {
        let orientation = UIDevice.current.orientation
        let landscape = orientation == UIDeviceOrientation.landscapeLeft || orientation == UIDeviceOrientation.landscapeRight
        return landscape
    }
    
    class func isPortrait() -> Bool {
        let orientation = UIDevice.current.orientation
        let portrait = orientation == UIDeviceOrientation.portrait
        return portrait
    }
}
