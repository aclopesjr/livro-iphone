//
//  DetalhesCarroViewController.swift
//  Carros Swift
//
//  Created by Antonio Lopes on 8/5/16.
//  Copyright © 2016 Antonio Lopes. All rights reserved.
//

import UIKit

class DetalhesCarroViewController: UIViewController {

    // MARK: Outlets
    @IBOutlet var image : UIImageView!
    @IBOutlet var descricao : UITextView!
    
    // MARK: Variables
    var carro : Carro?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let selectedCarro = carro {
            self.title = selectedCarro.nome
            
            let data = NSData(contentsOfURL: NSURL(string: selectedCarro.url_foto)!)!
            self.image.image = UIImage(data: data)
            self.descricao.text = selectedCarro.desc
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
