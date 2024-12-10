//
//  LaunchScreenVC.swift
//  ask-human
//
//  Created by IDEIO SOFT on 08/05/24.
//

import UIKit
import AVFoundation
import AVKit
import FLAnimatedImage

class LaunchScreenVC: UIViewController {
    @IBOutlet var viewAnimate: UIView!
    var player: AVQueuePlayer?
    var videoLooper: AVPlayerLooper?
    
    @IBOutlet var imgVw: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        SetMode()
   
    }
   
    override func viewWillAppear(_ animated: Bool) {

        uiSet()
    }
    func displayGIF() {
        let gifName: String
        
        if traitCollection.userInterfaceStyle == .dark {
            gifName = "ASKDARK"
        } else {
            gifName = "ASKLIGHT"
        }
        
        guard let gifURL = Bundle.main.url(forResource: gifName, withExtension: "gif") else {
            print("GIF file not found")
            return
        }
        guard let gifData = try? Data(contentsOf: gifURL) else {
            print("Failed to load GIF data")
            return
        }
        
        let animatedImage = FLAnimatedImage(animatedGIFData: gifData)
        let animatedImageView = FLAnimatedImageView()
        animatedImageView.frame = viewAnimate.bounds
        animatedImageView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        animatedImageView.contentMode = .scaleAspectFit  // or .scaleAspectFill
        
        animatedImageView.animatedImage = animatedImage
        viewAnimate.addSubview(animatedImageView)
    }
    
    func SetMode() {
        if Store.DarkMode == 0{
            applyUserInterfaceStyle(.dark)
            
            
        } else if Store.DarkMode == 1{
            applyUserInterfaceStyle(.light)
            
            
        }else{
            applyUserInterfaceStyle(.unspecified)
            
        }
    }
  
    
    func applyUserInterfaceStyle(_ style: UIUserInterfaceStyle) {
        guard let window = UIApplication.shared.windows.first else {
            return
        }
        window.overrideUserInterfaceStyle = style
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        if traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
            uiSet()
        }
    }
    
    func uiSet(){
        
        if traitCollection.userInterfaceStyle == .dark {
            imgVw.image = UIImage(named: "darkSplash")
        }else{
            imgVw.image = UIImage(named: "lightSplash")
        }
        displayGIF()
        DispatchQueue.main.asyncAfter(deadline: .now()+5){
            if Store.autoLogin == "true"{
                SceneDelegate().tabBarHomeVCRoot()
                
            }else if Store.autoLogin == "false"{
                SceneDelegate().loginVCRoot()
            }else{
                
                SceneDelegate().loginConfirmVCRoot()
                
            }
        }
    }
}
