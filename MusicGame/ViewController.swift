//
//  ViewController.swift
//  MusicGame
//
//  Created by nagata on 3/11/15.
//  Copyright (c) 2015 nagata. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController{
    
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var hanteiLabel: UILabel!
    
    var count: Float = 0.0
    var timer: NSTimer = NSTimer()
    
    var speed: Float = 0.0
    var label: UILabel!
    
    var number: Float = 10.0
    
    var audio:AVPlayer!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        if !timer.valid {
            timer = NSTimer.scheduledTimerWithTimeInterval(0.01,
                target: self,
                selector: Selector("up"),
                userInfo: nil,
                repeats: true            )
        }
        
        label = UILabel(frame: CGRectMake(0, 0, 50, 50))
        label.text = ""
        label.font = UIFont.systemFontOfSize(50)
        label.backgroundColor = UIColor.clearColor()
        self.view.addSubview(label)
        
        var appframe: CGRect = UIScreen.mainScreen().applicationFrame
        speed = Float(appframe.size.height) / 1.2
        
        //音楽ファイルの指定
        let audioPath = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("sc01", ofType: "mp3")!)
        //再生の準備
        audio = AVPlayer(URL: audioPath)
        //音楽を再生
        audio.play()
    }
    
    func up() {
        count = count + 0.01
        timeLabel.text = String(format:"%.2f" , count)
        if number - 1.2 <= count {
            label.text = "■"
            var y:Float = (count - number + 1.2) * speed - 75
            label.frame = CGRectMake(135, CGFloat(y), 50, 50)
        }
    }
    
    func hantei(number: Float) -> String {
        
        if count > number - 0.20 && count < number + 0.20 {        //もし経過時間が9.8秒〜10.2秒だったら
            return "PERFECT!"                                      //PERFECT!と表示
        } else if count > number - 0.30 && count < number + 0.30 { //もし経過時間が9.7秒〜10.3秒だったら
            return "GREAT!"                                        //GREAT!と表示
        } else if count > number - 0.50 && count < number + 0.50 { //もし経過時間が9.5秒〜10.5秒だったら
            return "GOOD!"                                         //GOOD!と表示
        } else {                                                   //もしそれ以外だったら
            return "BAD!"                                          //BADと表示
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func pushButton() {
        hanteiLabel.text = self.hantei(10.0)
        
        
        if timer.valid {
            timer.invalidate()
        }
    }
    
}











