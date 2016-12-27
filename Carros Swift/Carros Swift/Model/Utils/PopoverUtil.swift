//
//  PopoverUtil.swift
//  Carros Swift
//
//  Created by Antonio Lopes on 12/27/16.
//  Copyright © 2016 Antonio Lopes. All rights reserved.
//

import AVFoundation
import UIKit

class PopoverUtil {

    class func show(selfViewController: UIViewController, viewController: UIViewController, sourceView: UIView, width: CGFloat, height: CGFloat) {
        //tamanho do popover
        viewController.preferredContentSize = CGSize(width: width, height: height)
        viewController.modalPresentationStyle = UIModalPresentationStyle.popover
        
        //origem do popover
        viewController.popoverPresentationController?.sourceView = sourceView
        
        //mostra a view no popover
        selfViewController.present(viewController, animated: true, completion: nil)
    }
    
    class func show(selfViewController: UIViewController, viewController: UIViewController, source: UIBarButtonItem, width: CGFloat, height: CGFloat) {
        //tamanho do popover
        viewController.preferredContentSize = CGSize(width: width, height: height)
        viewController.modalPresentationStyle = UIModalPresentationStyle.popover
        
        //origem do popover
        viewController.popoverPresentationController?.barButtonItem = source
        
        //mostra a view no popover
        selfViewController.present(viewController, animated: true, completion: nil)
    }
}
