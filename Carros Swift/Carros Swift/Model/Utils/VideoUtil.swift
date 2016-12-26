//
//  VideoUtil.swift
//  Carros Swift
//
//  Created by Antonio Lopes on 12/15/16.
//  Copyright © 2016 Antonio Lopes. All rights reserved.
//

import Foundation
import MediaPlayer
import AVKit

class VideoUtil {
    
    var playerVC : AVPlayerViewController!
    var playerItem : AVPlayerItem!
    var player : AVPlayer!
    var playerLayer : AVPlayerLayer!
    
    // Reproduz o vídeo com um player utilizando uma view como conteiner
    func playFile(file: String, view: UIView) {
        
        if let path = Bundle.main.path(forResource: file, ofType: nil)  {
            let url = NSURL.fileURL(withPath: path)
            self.playUrl(url: url, view: view)
        }
    }
    
    // Reproduz o vídeo com um player utilizando uma view como conteiner
    func playUrl(url: URL, view: UIView) {
        // cria o componente que gerencia o vídeo
        if (self.player == nil) {
            if (self.playerVC == nil) {
                playerItem = AVPlayerItem.init(url: url)
                player = AVPlayer.init(playerItem: playerItem)
                
                playerVC = AVPlayerViewController.init()
                playerVC.player = player
                playerVC.showsPlaybackControls = true
                playerVC.view.frame = view.frame
                playerVC.view.sizeToFit()
                playerVC.videoGravity = AVLayerVideoGravityResizeAspect
                
                view.addSubview(playerVC.view)
                
                self.playerVC.player?.play()
            }
        }
        // inicia o video
        self.player!.play()
    }
    
    func pause() {
        self.player!.pause()
    }
    
    func stop() {
        self.player!.pause()
    }
    
    // Reproduz o filme em tela cheia
    func playFileFullScreen(file: String, viewController: UIViewController) {
        // converte o nome do arquivo em URL
        if let path = Bundle.main.path(forResource: file, ofType: nil)  {
            let url = NSURL.fileURL(withPath: path)
            self.playUrlFullScreen(url: url, viewController: viewController)
        }
    }
    
    func playUrlFullScreen(url: URL, viewController: UIViewController) {
        // cria o controller especializado em reproduzir vídeo
        if (self.playerVC == nil) {
            playerItem = AVPlayerItem.init(url: url)
            player = AVPlayer.init(playerItem: playerItem)
            
            playerVC = AVPlayerViewController.init()
            playerVC.player = player
            playerVC.showsPlaybackControls = true
            playerVC.videoGravity = AVLayerVideoGravityResizeAspect
            
            viewController.present(playerVC, animated: true, completion: { () -> Void in
                self.playerVC.player?.play()
            })
            
        }
    }
}
