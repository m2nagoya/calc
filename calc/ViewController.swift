//
//  ViewController.swift
//  電卓
//
//  Created by 武藤岳児 on 2020/06/23.
//  Copyright © 2020 Gackji. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    var audioPlayerInstance1 : AVAudioPlayer! = nil
    var audioPlayerInstance2 : AVAudioPlayer! = nil
    var audioPlayerInstance3 : AVAudioPlayer! = nil
    var audioPlayerInstance4 : AVAudioPlayer! = nil
    var numberOnScreen: Double = 0
    var previousNumber: Double = 0
    var performingMath = false
    var operation = 0
    
    @IBOutlet weak var label: UILabel!
    
    @IBAction func number(_ sender: UIButton) {
        if performingMath == true {
            label.text = String(sender.tag)
            numberOnScreen = Double(label.text!)!
            performingMath = false
        } else {
            label.text = label.text! + String(sender.tag)
            numberOnScreen = Double(label.text!)!
        }
        audioPlayerInstance1.currentTime = 0
        audioPlayerInstance1.play()
    }
    
    @IBAction func button(_ sender: UIButton) {
        if label.text != "" && sender.tag != 11 && sender.tag != 16 && !performingMath {
            previousNumber = Double(label.text!)!
            if sender.tag == 12 {
                label.text = "+"
            } else if sender.tag == 13 {
                label.text = "-"
            } else if sender.tag == 14 {
                label.text = "×"
            } else if sender.tag == 15 {
                label.text = "÷"
            }
            operation = sender.tag
            performingMath = true;
            audioPlayerInstance2.currentTime = 0
            audioPlayerInstance2.play()
        // 四則演算を実行
        } else if sender.tag == 16 {
            if operation == 12 {
                label.text = String(previousNumber + numberOnScreen)
            } else if operation == 13 {
                label.text = String(previousNumber - numberOnScreen)
            } else if operation == 14 {
                label.text = String(previousNumber * numberOnScreen)
            } else if operation == 15 {
                label.text = String(previousNumber / numberOnScreen)
            }
            audioPlayerInstance3.currentTime = 0
            audioPlayerInstance3.play()
        // クリアー
        } else if sender.tag == 11 {
            label.text = ""
            previousNumber = 0;
            numberOnScreen = 0;
            operation = 0;
            audioPlayerInstance4.currentTime = 0
            audioPlayerInstance4.play()
        }
    }
    
    // 初期化
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let soundFilePath1 = Bundle.main.path(forResource: "button", ofType: "mp3")!
        let soundFilePath2 = Bundle.main.path(forResource: "calc",   ofType: "mp3")!
        let soundFilePath3 = Bundle.main.path(forResource: "equal",  ofType: "mp3")!
        let soundFilePath4 = Bundle.main.path(forResource: "clear",  ofType: "mp3")!
        let sound1:URL = URL(fileURLWithPath: soundFilePath1)
        let sound2:URL = URL(fileURLWithPath: soundFilePath2)
        let sound3:URL = URL(fileURLWithPath: soundFilePath3)
        let sound4:URL = URL(fileURLWithPath: soundFilePath4)
        do {
            audioPlayerInstance1 = try AVAudioPlayer(contentsOf: sound1, fileTypeHint:nil)
            audioPlayerInstance2 = try AVAudioPlayer(contentsOf: sound2, fileTypeHint:nil)
            audioPlayerInstance3 = try AVAudioPlayer(contentsOf: sound3, fileTypeHint:nil)
            audioPlayerInstance4 = try AVAudioPlayer(contentsOf: sound4, fileTypeHint:nil)
        } catch {
            print("AVAudioPlayerインスタンス作成でエラー")
        }
        audioPlayerInstance1.prepareToPlay()
        audioPlayerInstance2.prepareToPlay()
        audioPlayerInstance3.prepareToPlay()
        audioPlayerInstance4.prepareToPlay()
    }

    // シェイクでクリアー
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if event?.subtype == UIEvent.EventSubtype.motionShake{
            label.text = ""
            previousNumber = 0;
            numberOnScreen = 0;
            operation = 0;
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

