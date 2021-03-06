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
    @IBOutlet var image : DownloadImageView!
    @IBOutlet var descricao : UITextView!
    
    // MARK: Variables
    var carro : Carro?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let selectedCarro = carro {
            self.title = selectedCarro.nome
            self.image.setUrl(selectedCarro.url_foto!)
            self.descricao.text = selectedCarro.desc
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func visualizarMapa() {
        let vc = MapViewController(nibName: "MapViewController", bundle: nil)
        vc.carro = self.carro
        self.navigationController!.pushViewController(vc, animated: true)
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
