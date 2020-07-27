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
    var array: [String] = []
    
    @IBOutlet weak var label1: UILabel!
    
    @IBAction func number(_ sender: UIButton) {
        if label1.text != "Error" {
            if performingMath == true {
                label1.text = String(sender.tag)
                numberOnScreen = Double(label1.text!)!
                performingMath = false
            } else {
                label1.text = label1.text! + String(sender.tag)
                numberOnScreen = Double(label1.text!)!
            }
        }
        audioPlayerInstance1.currentTime = 0
        audioPlayerInstance1.play()
    }
    
    func culc() {
        if operation == 12 {
            if (previousNumber + numberOnScreen) == Double(Int(previousNumber + numberOnScreen)) {
                label1.text = String(Int(previousNumber + numberOnScreen))
            } else {
                label1.text = String(previousNumber + numberOnScreen)
            }
        } else if operation == 13 {
            if (previousNumber - numberOnScreen) == Double(Int(previousNumber - numberOnScreen)) {
                label1.text = String(Int(previousNumber - numberOnScreen))
            } else {
                label1.text = String(previousNumber - numberOnScreen)
            }
        } else if operation == 14 {
            if (previousNumber * numberOnScreen) == Double(Int(previousNumber * numberOnScreen)) {
                label1.text = String(Int(previousNumber * numberOnScreen))
            } else {
                label1.text = String(previousNumber * numberOnScreen)
            }
        } else if operation == 15 {
            if (numberOnScreen != 0) {
                if (previousNumber / numberOnScreen) == Double(Int(previousNumber / numberOnScreen)) {
                    label1.text = String(Int(previousNumber / numberOnScreen))
                } else {
                    label1.text = String(previousNumber / numberOnScreen)
                }
            } else {
                label1.text = "Error";
            }
        }
    }
    
    @IBAction func button(_ sender: UIButton) {
        // 関数ボタン(+,-,×,÷)が押された時
        if label1.text != "" && sender.tag != 11 && sender.tag != 16 {
            if !performingMath && label1.text != "Error" {
                if operation == 0 {
                    previousNumber = Double(label1.text!)!
                    if sender.tag == 12 {
                        label1.text = "+"
                    } else if sender.tag == 13 {
                        label1.text = "-"
                    } else if sender.tag == 14 {
                        label1.text = "×"
                    } else if sender.tag == 15 {
                        label1.text = "÷"
                    }
                    operation = sender.tag
                    performingMath = true;
                } else {
                    culc(); // 計算
                    previousNumber = Double(label1.text!)!
                    numberOnScreen = 0;
                    operation = 0;
                    if sender.tag == 12 {
                        label1.text = "+"
                    } else if sender.tag == 13 {
                        label1.text = "-"
                    } else if sender.tag == 14 {
                        label1.text = "×"
                    } else if sender.tag == 15 {
                        label1.text = "÷"
                    }
                    operation = sender.tag
                    performingMath = true;
                }
            }
            audioPlayerInstance2.currentTime = 0
            audioPlayerInstance2.play()
        // 演算を実行(=)
        } else if sender.tag == 16 {
            if label1.text != "Error" && label1.text != "" {
                culc(); // 計算
                if label1.text != "Error" {
//                    if label1.text != array[0] {
//                        array.insert(label1.text!,at: 0);
//                    }
                    previousNumber = Double(label1.text!)!
                }
            }
            numberOnScreen = 0;
            operation = 0;
            audioPlayerInstance3.currentTime = 0
            audioPlayerInstance3.play()
        // クリアー
        } else if sender.tag == 11 {
            label1.text = ""
            array.removeAll();
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
            label1.text = ""
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

