//
//  AutoPanVC.swift
//  AudioKit-Demo
//
//  Created by Mohammed Azeem Azeez on 27/10/2019.
//  Copyright © 2019 J'Overt Matics. All rights reserved.
//

import UIKit
import AudioKit
import AudioKitUI

class AutoPanVC: AKLiveViewController {
   var player: AKPlayer!
   var file: AKAudioFile!
    override func viewDidLoad() {
       addPanUI()
      
}
    func addPanUI() {
                     do {
                         file = try AKAudioFile(readFileName: "mixloop.wav")
                     } catch {
                         AKLog("File Not Found")
                         return
                     }
                player = AKPlayer(audioFile: file)
                player.isLooping = true

                 let effect = AKOperationEffect(player) { input, parameters in
                     let oscillator = AKOperation.sineWave(frequency: parameters[speedIndex], amplitude: parameters[depthIndex])
                     return input.pan(oscillator)
                 }

                 effect.parameters = [10, 1]
                 AudioKit.output = effect
                        do {
                            try AudioKit.start()
                        } catch {
                            AKLog("AudioKit did not start!")
                        }
       
        addTitle("AutoPan- Hidden in Nav Bar")
        addTitle("AutoPan")
        addView(AKResourcesAudioFileLoaderView(player: player, filenames: ["mixloop.wav"]))
        addView(AKSlider(property: "Speed", value: effect.speed, range: 0.1 ... 25) { sliderValue in
                                       effect.speed = sliderValue
                                   })
        addView(AKSlider(property: "Depth", value: effect.depth) { sliderValue in
                                       effect.depth = sliderValue
                                   })  }
   
    

}
extension AKOperationEffect {
    var speed: Double {
        get { return self.parameters[speedIndex] }
        set(newValue) { self.parameters[speedIndex] = newValue }
    }
    var depth: Double {
        get { return self.parameters[depthIndex] }
        set(newValue) { self.parameters[depthIndex] = newValue }
    }
}

