//
//  SobreViewController.swift
//  Carros Swift
//
//  Created by Antonio Lopes on 8/4/16.
//  Copyright © 2016 Antonio Lopes. All rights reserved.
//

import UIKit

let URL_SOBRE = "http://www.livroiphone.com.br/carros/sobre.htm"

class SobreViewController: UIViewController, UIWebViewDelegate {

    // MARK: Outlets
    @IBOutlet var webView : UIWebView!
    @IBOutlet var progress : UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Sobre"
        
        progress.startAnimating()
        
        let url = URL(string: URL_SOBRE)!
        webView.loadRequest(URLRequest(url:url))
        
        //webView.delegate = self;
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

    // MARK: WebView
    func webViewDidFinishLoad(_ webView: UIWebView) {
        progress.stopAnimating()
    }
}
