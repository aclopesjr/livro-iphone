//
//  DetalhesCarroViewController.swift
//  Carros Swift
//
//  Created by Antonio Lopes on 8/5/16.
//  Copyright © 2016 Antonio Lopes. All rights reserved.
//

import UIKit

class DetalhesCarroViewController: UIViewController, UISplitViewControllerDelegate {

    // MARK: Outlets
    @IBOutlet var image : DownloadImageView!
    @IBOutlet var descricao : UITextView!
    
    // MARK: Variables
    var carro : Carro?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let selectedCarro = carro {
            updateCarro(carro: selectedCarro)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        if (Utils.isIphone()) {

        }
    }

    @IBAction func visualizarMapa() {
        //let vc = MapViewController(nibName: "MapViewController", bundle: nil)
        let vc = GpsMapViewController(nibName: "MapViewController", bundle: nil)
        vc.carro = self.carro
        self.navigationController!.pushViewController(vc, animated: true)
    }
    
    @IBAction func visualizarVideo() {
        let videoUtil = VideoUtil()
        let url = self.carro!.url_video?.url()
        videoUtil.playUrlFullScreen(url: url!, viewController: self)
        
//        let vc = VideoViewController(nibName: "VideoViewController", bundle: nil)
//        vc.carro = self.carro
//        self.navigationController!.pushViewController(vc, animated: true)
    }
    
    func updateCarro(carro: Carro) {
        self.carro = carro
        self.title = carro.nome
        self.descricao.text = carro.desc
        self.image.setUrl(carro.url_foto!)
    }
}
