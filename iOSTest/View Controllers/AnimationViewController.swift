//
//  AnimationViewController.swift
//  iOSTest
//
//  Copyright © 2020 Rapptr Labs. All rights reserved.

import UIKit

class AnimationViewController: UIViewController {
    
    /**
     * =========================================================================================
     * INSTRUCTIONS
     * =========================================================================================
     * 1) Make the UI look like it does in the mock-up.
     *
     * 2) Logo should fade out or fade in when the user hits the Fade In or Fade Out button
     *
     * 3) User should be able to drag the logo around the screen with his/her fingers
     *
     * 4) Add a bonus to make yourself stick out. Music, color, fireworks, explosions!!! Have Swift experience? Why not write the Animation
     *    section in Swfit to show off your skills. Anything your heart desires!
     *
     **/
    
    // MARK: - Lifecycle
    
    @IBOutlet weak var fade: UIButton!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var outsideView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Animation"
        
        fade.backgroundColor = UIColor(hexString: "#0E5C89")
        fade.setTitleColor(UIColor.white, for: .normal)
        image.image = UIImage(named: "ic_logo")
        self.outsideView.alpha = 0.0
        
    }
    
    // MARK: - Actions
    @IBAction func backAction(_ sender: Any) {
        let mainMenuViewController = MenuViewController()
        self.navigationController?.pushViewController(mainMenuViewController, animated: true)
    }
    
    @IBAction func didPressFade(_ sender: Any) {
        
        if self.outsideView.alpha == 0.0 {
            UIView.animate(withDuration: 1.5, delay: 0.2, options: .curveEaseIn, animations: {
                self.outsideView.alpha = 1.0
            })
        }
    }
}
