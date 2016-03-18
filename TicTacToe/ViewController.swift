//
//  ViewController.swift
//  TicTacToe
//
//  Created by apple on 17/03/16.
//  Copyright © 2016 pubnub. All rights reserved.
//

import UIKit

class ViewController: UIViewController, PNObjectEventListener{
    
    @IBOutlet weak var b1: UIButton!
    @IBOutlet weak var b2: UIButton!
    @IBOutlet weak var b9: UIButton!
    @IBOutlet weak var b8: UIButton!
    @IBOutlet weak var b7: UIButton!
    @IBOutlet weak var b6: UIButton!
    @IBOutlet weak var b5: UIButton!
    @IBOutlet weak var b4: UIButton!
    @IBOutlet weak var b3: UIButton!
    
    var place = [[3]]
    var dupli:String = ""
    var mark: String = ""
    var value: Int = 0
    //let mark2: String = "X"
    override func viewDidLoad() {
        super.viewDidLoad()
        place = [[-1,-1,-1],[-1,-1,-1],[-1,-1,-1]]
        let data: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        data.clientData.addListener(self)
        
    }
    
    @IBAction func Button1(sender: AnyObject) {
        place[0][0] = value
        b1.setTitle(mark, forState: UIControlState.Normal)
        b1.userInteractionEnabled = false
        if result() == "" {
            publishData("b1")
        } else {
            publishData(result())
        }
    }
    @IBAction func button2(sender: AnyObject) {
        place[0][1] = value
        b2.setTitle(mark, forState: UIControlState.Normal)
        b2.userInteractionEnabled = false
        if result() == "" {
            publishData("b2")
        } else {
            publishData(result())
        }
        
    }
    
    @IBAction func button3(sender: AnyObject) {
        place[0][2] = value
        b3.setTitle(mark, forState: UIControlState.Normal)
        b3.userInteractionEnabled = false
        if result() == "" {
            publishData("b3")
        } else {
            publishData(result())
        }
        
    }
    
    @IBAction func button4(sender: AnyObject) {
        place[1][0] = value
        b4.setTitle(mark, forState: UIControlState.Normal)
        b4.userInteractionEnabled = false
        if result() == "" {
            publishData("b4")
        } else {
            publishData(result())
        }
        
    }
    
    @IBAction func button5(sender: AnyObject) {
        place[1][1] = value
        b5.setTitle(mark, forState: UIControlState.Normal)
        b5.userInteractionEnabled = false
        if result() == "" {
            publishData("b5")
        } else {
            publishData(result())
        }
    }
    
    @IBAction func button6(sender: AnyObject) {
        place[1][2] = value
        b6.setTitle(mark, forState: UIControlState.Normal)
        b6.userInteractionEnabled = false
        if result() == "" {
            publishData("b6")
        } else {
            publishData(result())
        }
        
    }
    
    @IBAction func button7(sender: AnyObject) {
        place[2][0] = value
        b7.setTitle(mark, forState: UIControlState.Normal)
        b7.userInteractionEnabled = false
        if result() == "" {
            publishData("b7")
        } else {
            publishData(result())
        }
        
    }
    
    @IBAction func button8(sender: AnyObject) {
        place[2][1] = value
        b8.setTitle(mark, forState: UIControlState.Normal)
        b8.userInteractionEnabled = false
        if result() == "" {
            publishData("b8")
        } else {
            publishData(result())
        }
        
    }
    
    @IBAction func button9(sender: AnyObject) {
        place[2][2] = value
        b9.setTitle(mark, forState: UIControlState.Normal)
        b9.userInteractionEnabled = false
        if result() == "" {
            publishData("b9")
        } else {
            publishData(result())
        }
        
    }
    
    
    @IBOutlet weak var bp2: UIButton!
    @IBOutlet weak var bp1: UIButton!
    @IBAction func player1(sender: AnyObject) {
        mark = "O"
        value = 0
        bp1.userInteractionEnabled = false
        bp2.userInteractionEnabled = false
    }
    @IBAction func player2(sender: AnyObject) {
        mark = "X"
        value = 1
        bp2.userInteractionEnabled = false
        bp1.userInteractionEnabled = false
    }
    //    func receiveData(){
    //        let rcvMsg = data.receiveMessage
    //        print(rcvMsg)
    //    }
    
    func publishData(message: String){
        dupli = message
        let data: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        self.view.userInteractionEnabled = false
        let jsonObject: NSMutableDictionary = NSMutableDictionary()
        jsonObject["text"] = message
        
        data.clientData.publish(jsonObject, toChannel: "TicTac_Channel", compressed: false, withCompletion: nil)
    }
    func result() -> String{
        var tieFlag: Bool = false
        
        
        for var i = 0; i < 3; i++ {
            if place[i][0] == value && place [i][1] == value && place [i][2] == value {
                if i == 0 {
                    b1.setTitleColor(UIColor.redColor(), forState: UIControlState.Normal)
                    b2.setTitleColor(UIColor.redColor(), forState: UIControlState.Normal)
                    b3.setTitleColor(UIColor.redColor(), forState: UIControlState.Normal)
                } else if i == 1 {
                    b4.setTitleColor(UIColor.redColor(), forState: UIControlState.Normal)
                    b5.setTitleColor(UIColor.redColor(), forState: UIControlState.Normal)
                    b6.setTitleColor(UIColor.redColor(), forState: UIControlState.Normal)
                } else {
                    b7.setTitleColor(UIColor.redColor(), forState: UIControlState.Normal)
                    b8.setTitleColor(UIColor.redColor(), forState: UIControlState.Normal)
                    b9.setTitleColor(UIColor.redColor(), forState: UIControlState.Normal)
                }
                return "\(mark) Won"
            }
            if place[0][i] == value && place [1][i] == value && place [2][i] == value {
                return "\(mark) Won"
            }
            
            for var j = 0 ; j < 3; j++ {
                if place[i][j] == -1 {
                    tieFlag = true
                }
                
            }
            
        }
        if place[0][0] == value && place [1][1] == value && place [2][2] == value {
            return "\(mark) Won"
        }
        
        if place[2][0] == value && place [1][1] == value && place [0][2] == value {
            return "\(mark) Won"
        }
        
        if tieFlag == false {
            return "Match Tie"
        }
        
        return ""
    }
    //pubnub function
    func client(client: PubNub, didReceiveMessage message: PNMessageResult) {
        
        let receiveMessage = message.data.message!["text"]!
        var mark1: String = ""
        var value1: Int = 0
        if mark == "X" {
            mark1 = "O"
            value1 = 0
        }else {
            mark1 = "X"
            value1 = 1
        }
        
        if dupli != receiveMessage as! String{
            
            switch receiveMessage as! String {
            case "b1":
                place[0][0] = value1
                b1.setTitle(mark1, forState: UIControlState.Normal)
                b1.userInteractionEnabled = false
            case "b2":
                place[0][1] = value1
                b2.setTitle(mark1, forState: UIControlState.Normal)
                b2.userInteractionEnabled = false
            case "b3":
                place[0][2] = value1
                b3.setTitle(mark1, forState: UIControlState.Normal)
                b3.userInteractionEnabled = false
            case "b4":
                place[1][0] = value1
                b4.setTitle(mark1, forState: UIControlState.Normal)
                b4.userInteractionEnabled = false
            case "b5":
                place[1][1] = value1
                b5.setTitle(mark1, forState: UIControlState.Normal)
                b5.userInteractionEnabled = false
            case "b6":
                place[1][2] = value1
                b6.setTitle(mark1, forState: UIControlState.Normal)
                b6.userInteractionEnabled = false
            case "b7":
                place[2][0] = value1
                b7.setTitle(mark1, forState: UIControlState.Normal)
                b7.userInteractionEnabled = false
            case "b8":
                place[2][1] = value1
                b8.setTitle(mark1, forState: UIControlState.Normal)
                b8.userInteractionEnabled = false
                
            case "b9":
                place[2][2] = value1
                b9.setTitle(mark1, forState: UIControlState.Normal)
                b9.userInteractionEnabled = false
            case "Won":
                self.view.userInteractionEnabled = false
                let alert = UIAlertController(title: "Won", message: "\(mark1) Won", preferredStyle: UIAlertControllerStyle.Alert)
                let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default) {
                    UIAlertAction in
                    self.reset()
                }
                alert.addAction(okAction)
                self.presentViewController(alert, animated: true, completion: nil)
                
               
                
                
            case "Tie":
                self.view.userInteractionEnabled = false
                let alert = UIAlertController(title: "Tie", message: "Match Tie", preferredStyle: UIAlertControllerStyle.Alert)
                let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default) {
                    UIAlertAction in
                    self.reset()
                }
                alert.addAction(okAction)
                self.presentViewController(alert, animated: true, completion: nil)
                print("Tie")
               
                
                
            default: break
                
            }
            self.view.userInteractionEnabled = true
            print(receiveMessage!)
            print(place)
        }
    }
    func reset() {
        place = [[-1,-1,-1],[-1,-1,-1],[-1,-1,-1]]
        toggleButtons()
        resetButtonLabel()
        print(place)
    }
    
    func toggleButtons() {
        b1.userInteractionEnabled = true
        b2.userInteractionEnabled = true
        b3.userInteractionEnabled = true
        b4.userInteractionEnabled = true
        b5.userInteractionEnabled = true
        b6.userInteractionEnabled = true
        b7.userInteractionEnabled = true
        b8.userInteractionEnabled = true
        b9.userInteractionEnabled = true
    }
    
    func resetButtonLabel() {
        b1.setTitle("", forState: UIControlState.Normal)
        b2.setTitle("", forState: UIControlState.Normal)
        b3.setTitle("", forState: UIControlState.Normal)
        b4.setTitle("", forState: UIControlState.Normal)
        b5.setTitle("", forState: UIControlState.Normal)
        b6.setTitle("", forState: UIControlState.Normal)
        b7.setTitle("", forState: UIControlState.Normal)
        b8.setTitle("", forState: UIControlState.Normal)
        b9.setTitle("", forState: UIControlState.Normal)
    }
}

