//
//  FirstViewController.swift
//  ios
//
//  Created by Pei Pei on 2015-08-04.
//  Copyright (c) 2015 Pei Pei. All rights reserved.
//

import UIKit
import AVFoundation
import MediaPlayer


class FirstViewController: UIViewController {

    var player: AVAudioPlayer = AVAudioPlayer()
    var moviePlayer: MPMoviePlayerController?
    
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
    
    
    func play_audio(){
        var Timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: Selector("updateSlider"), userInfo: nil, repeats: true)
        
        
        var audioPath = NSBundle.mainBundle().pathForResource("bukeshuo", ofType: "mp3")!
        
        var error : NSError? = nil
        
        player = AVAudioPlayer(contentsOfURL: NSURL(string: audioPath), error: &error)
        
        player.prepareToPlay()
        
        if error != nil {
            
            println(error)
            
        }
        
    }
    
    
    func play_video(){
        
        if let
            path = NSBundle.mainBundle().pathForResource("bukeshuo", ofType:"mp4"),
            url = NSURL(fileURLWithPath: path),
            moviePlayer = MPMoviePlayerController(contentURL: url) {
                self.moviePlayer = moviePlayer
                moviePlayer.view.frame = self.view.bounds
                moviePlayer.prepareToPlay()
                moviePlayer.scalingMode = .AspectFill
                self.view.addSubview(moviePlayer.view)
        } else {
            debugPrintln("Ops, something wrong when playing video.m4v")
        }
    }
    
    func background_play_setup(){
        var categoryError: NSError?
        if AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback, error: &categoryError) {
            println("AVAudioSession Category Playback OK")
            var activateError: NSError?
            if AVAudioSession.sharedInstance().setActive(true, error: &activateError) {
                println("AVAudioSession is Active")
            } else if let activateError = activateError {
                println(activateError.description)
            }
        } else if let categoryError = categoryError {
            println(categoryError.description)
        }

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        background_play_setup()
        //play_audio()
        play_video()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    

}

