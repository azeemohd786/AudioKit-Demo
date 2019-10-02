//
//  ViewController.swift
//  AudioKit-Demo
//
//  Created by Mohammed Azeem Azeez on 02/10/2019.
//  Copyright © 2019 J'Overt Matics. All rights reserved.
//

import UIKit
import AudioKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
  
 
       
    }
    
    
    @IBAction func playEngineBtn(_ sender: Any) {
        // Create your engine and start the player
        let engine = AudioEngine()
        engine.player.play()
        
    }
  

}


