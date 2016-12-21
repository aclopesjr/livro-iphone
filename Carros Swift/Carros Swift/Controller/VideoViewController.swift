//
//  VideoViewController.swift
//  Carros Swift
//
//  Created by Antonio Lopes on 10/20/16.
//  Copyright © 2016 Antonio Lopes. All rights reserved.
//

import UIKit

class VideoViewController: UIViewController {

    var carro : Carro?
    @IBOutlet var webView : UIWebView!
    let videoUtil = VideoUtil()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let url = self.carro!.url_video?.url()
        self.videoUtil.playUrl(url: url!, view: self.webView)
        
//        let request = URLRequest(url: url!)
//        self.webView.loadRequest(request)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
