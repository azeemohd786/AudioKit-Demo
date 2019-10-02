//
//  AudioEngine.swift
//  AudioKit-Demo
//
//  Created by Mohammed Azeem Azeez on 02/10/2019.
//  Copyright © 2019 J'Overt Matics. All rights reserved.
//

import Foundation
import AudioKit
let speedIndex = 0
let depthIndex = 1
// Create a class to handle the audio set up
class AudioEngine {

    // Declare your nodes as instance variables
    var player: AKPlayer!
    var delay: AKDelay!
    var reverb: AKReverb!
    var file: AKAudioFile!

    init() {
        // Set up a player to the loop the file's playback
        do {
            file = try AKAudioFile(readFileName: "mixloop.wav")
        } catch {
            AKLog("File Not Found")
            return
        }
        player = AKPlayer(audioFile: file)
        player.isLooping = true
        player.buffering = .always

        // Next we'll connect the audio player to a delay effect
        delay = AKDelay(player)

        // Set the parameters of the delay here
        delay.time = 0.1 // seconds
        delay.feedback = 0.5 // Normalized Value 0 - 1
        delay.dryWetMix = 0.2 // Normalized Value 0 - 1

        // Continue adding more nodes as you wish, for example, reverb:
        reverb = AKReverb(delay)
        reverb.loadFactoryPreset(.cathedral)

        AudioKit.output = reverb
        do {
            try AudioKit.start()
        } catch {
            AKLog("AudioKit did not start!")
        }
    }
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
