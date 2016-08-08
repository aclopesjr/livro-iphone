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
    var tipo = "classicos"
    
    // MARK: Outlet
    @IBOutlet var tabView : UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.automaticallyAdjustsScrollViewInsets = false
        
        self.title = "Carros"
        
        self.buscaCarros()
        
        //self.tabView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.tabView.registerNib(UINib(nibName: "CarroTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func alterarTipo(sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 1:
            tipo = "esportivos"
        case 2:
            tipo = "luxo"
        default:
            tipo = "classicos"
        }
        
        self.buscaCarros()
    }

    func buscaCarros() {
        self.carros = CarroService.getCarroByTypeFromFile(tipo)
        self.tabView.reloadData()
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
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.carros.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        let carro = self.carros[indexPath.row]
        
        let cell = self.tabView.dequeueReusableCellWithIdentifier("cell")! as! CarroTableViewCell
        cell.lNome.text = carro.nome
        cell.lDescricao.text = carro.desc
        
        let data = NSData(contentsOfURL: NSURL(string: carro.url_foto)!)!
        cell.ivImage!.image = UIImage(data: data)
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let carro = self.carros[indexPath.row]
        //Alerta.alerta("Selecionou o carro: " + carro.nome, viewController: self)
                                                                                
        let detalhesCarroViewController = DetalhesCarroViewController(nibName: "DetalhesCarroViewController", bundle: nil)
        detalhesCarroViewController.carro = carro
        self.navigationController!.pushViewController(detalhesCarroViewController, animated: true)
    }
}
