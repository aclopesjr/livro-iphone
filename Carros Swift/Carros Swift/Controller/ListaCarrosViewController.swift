//
//  ListaCarrosViewController.swift
//  Carros Swift
//
//  Created by Antonio Lopes on 8/4/16.
//  Copyright © 2016 Antonio Lopes. All rights reserved.
//

import UIKit

class ListaCarrosViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    // MARK: Variables
    var carros : Array<Carro> = []
    
    // MARK: Outlet
    @IBOutlet var tabView : UITableView!
    @IBOutlet var progress : UIActivityIndicatorView!
    @IBOutlet var segmentControl : UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.automaticallyAdjustsScrollViewInsets = false
        self.title = "Carros"
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Atualizar", style: UIBarButtonItemStyle.plain, target: self, action: #selector(self.buscaCarros(_:)))
        
        if let tipo = Prefs.getObjectForKey("selectedSegmentIndex") as! NSInteger! {
            self.segmentControl.selectedSegmentIndex = tipo
        }
        
        self.buscaCarros(true)
        
        //self.tabView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.tabView.register(UINib(nibName: "CarroTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func alterarTipo(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 1:
            Prefs.setObjectForKey("esportivos" as NSObject, chave: "tipo")
        case 2:
            Prefs.setObjectForKey("luxo" as NSObject, chave: "tipo")
        default:
            Prefs.setObjectForKey("classicos" as NSObject, chave: "tipo")
        }
        
        Prefs.setObjectForKey(sender.selectedSegmentIndex as NSObject, chave: "selectedSegmentIndex")
        
        self.buscaCarros(true)
    }

    func buscaCarros(_ withCache:Bool) {
        self.progress.startAnimating()
        
        var tipo = "classicos"
        if let tipoStoreged = Prefs.getObjectForKey("tipo") as! String! {
            tipo = tipoStoreged
        }
        
        CarroService.getCarrosByTipo(tipo, withCache: withCache, andCallback:  { (carros: Array<Carro>, error: NSError?) -> Void in
            if error != nil {
                Alerta.alerta("Erro: " + (error?.localizedDescription)!, viewController: self)
            } else {
                self.carros = carros
                self.tabView.reloadData()
                self.progress.stopAnimating()
            }
        } )
        
//        CarroService.getCarrosByTipo(tipo, withCache: withCache, andCallback: { (carros: Array<Carro>, error: NSError!) -> Void in
//            if error != nil {
//                Alerta.alerta("Erro: " + error.localizedDescription, viewController: self)
//            } else {
//                self.carros = carros
//                self.tabView.reloadData()
//                self.progress.stopAnimating()
//            }
//        } as! (Array<Carro>, NSError?) -> Void)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: DataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.carros.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let carro = self.carros[(indexPath as NSIndexPath).row]
        
        let cell = self.tabView.dequeueReusableCell(withIdentifier: "cell")! as! CarroTableViewCell
        cell.lNome.text = carro.nome
        cell.lDescricao.text = carro.desc
        cell.ivImage!.setUrl(carro.url_foto!)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let carro = self.carros[(indexPath as NSIndexPath).row]
        //Alerta.alerta("Selecionou o carro: " + carro.nome, viewController: self)
                                                                                
        let detalhesCarroViewController = DetalhesCarroViewController(nibName: "DetalhesCarroViewController", bundle: nil)
        detalhesCarroViewController.carro = carro
        self.navigationController!.pushViewController(detalhesCarroViewController, animated: true)
    }
}
