//
//  FirstViewController.swift
//  ios
//
//  Created by Pei Pei on 2015-08-04.
//  Copyright (c) 2015 Pei Pei. All rights reserved.
//

import UIKit
import AVFoundation

class FirstViewController: UIViewController {

    var player: AVAudioPlayer = AVAudioPlayer()
    
    
    @IBOutlet weak var playPause: UIButton!
    
    @IBAction func playPauseButton(sender: AnyObject) {
        if player.playing {
            
            player.pause()
            playPause.setTitle("Play", forState: UIControlState.Normal)
            
            
        } else {
            
            player.play()
            playPause.setTitle("Pause", forState: UIControlState.Normal)
            
        }
    }
    
    @IBAction func stop(sender: AnyObject) {
        player.stop()
        playPause.setTitle("Play", forState: UIControlState.Normal)
        player.currentTime = 0;
    }
    
    
    
    @IBAction func sliderChanged(sender: AnyObject) {
        print("HI")
        player.currentTime = NSTimeInterval(sliderValue.value * Float(player.duration))
        
        
    }
    
    
    @IBOutlet var sliderValue: UISlider!
    
    func updateSlider(){
        sliderValue.value = Float(player.currentTime)/Float(player.duration)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        var Timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: Selector("updateSlider"), userInfo: nil, repeats: true)
        
        
        var audioPath = NSBundle.mainBundle().pathForResource("bukeshuo", ofType: "mp3")!
        
        var error : NSError? = nil
        
        player = AVAudioPlayer(contentsOfURL: NSURL(string: audioPath), error: &error)
        
        player.prepareToPlay()
        
        if error != nil {
            
            println(error)
            
        }
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    

}

