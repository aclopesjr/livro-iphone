//
//  DownloadImageView.swift
//  Carros Swift
//
//  Created by Antonio Lopes on 8/9/16.
//  Copyright © 2016 Antonio Lopes. All rights reserved.
//

import UIKit

class DownloadImageView: UIImageView {

    // MARK: Local Variables
    var progress : UIActivityIndicatorView!
    let queue = OperationQueue()
    let mainQueue = OperationQueue.main
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        createProgress()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createProgress()
    }
    
    func createProgress() {
        progress = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
        addSubview(progress)
    }

    override func layoutSubviews() {
        progress.center = convert(self.center, to: self.superview)
    }
    
    func setUrl(_ url: String) {
        setUrl(url, cache: true)
    }
    
    func setUrl(_ url: String, cache: Bool) {
        self.image = nil
        queue.cancelAllOperations()
        progress.startAnimating()
        queue.addOperation( { self.downloadImg(url, cache: true) } )
    }
    
    func downloadImg(_ url: String, cache: Bool) {
        var data : Data!
        if !cache {
            data = try! Data(contentsOf: URL(string: url)!)
        } else {
            var path = url
            path = path.replacingOccurrences(of: "/", with: "_")
            path = path.replacingOccurrences(of: "\\", with: "_")
            path = path.replacingOccurrences(of: ":", with: "_")
            path = NSHomeDirectory() + "/Documents/" + path
            
            if FileManager.default.fileExists(atPath: path) {
                data = try? Data(contentsOf: URL(fileURLWithPath: path))
            } else {
                data = try! Data(contentsOf: URL(string: url)!)
                try! data.write(to: URL(fileURLWithPath: path))
            }
        }
        
        mainQueue.addOperation( { self.showImg(data) } )
    }
    
    func showImg(_ data: Data) {
        if data.count == 0 {
            return;
        }
        
        self.image = UIImage(data: data)
        
        progress.stopAnimating()
    }
}
