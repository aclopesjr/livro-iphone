//
//  ListaCarrosViewController.swift
//  Carros Swift
//
//  Created by Antonio Lopes on 8/4/16.
//  Copyright © 2016 Antonio Lopes. All rights reserved.
//

import UIKit

class ListaCarrosViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    // MARK: Outlet
    @IBOutlet var tabView : UITableView!
    
    var carros : Array<Carro> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Carros"
        
        self.carros = CarroService.getCarros()
        
        self.tabView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
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

    // MARK: DataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.carros.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        let carro = self.carros[indexPath.row]
        
        let cell = self.tabView.dequeueReusableCellWithIdentifier("cell")! as UITableViewCell
        cell.textLabel!.text = carro.nome
        cell.imageView!.image = UIImage(named: carro.url_foto)
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let carro = self.carros[indexPath.row]
        Alerta.alerta("Selecionou o carro: " + carro.nome, viewController: self)
    }
}
