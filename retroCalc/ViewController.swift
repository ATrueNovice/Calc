//
//  ViewController.swift
//  retroCalc
//
//  Created by New on 1/9/17.
//  Copyright © 2017 HSI. All rights reserved.
//

import UIKit
//This is the class that has the audio player.
import AVFoundation
class ViewController: UIViewController {

    //Textlabel
    @IBOutlet weak var outputLbl: UILabel!
    
    
    //Links the button to the audio player that plays the sound.
    var btnSound = AVAudioPlayer()
    
    
    //Sets the cases for all logic operators.
    enum Operation: String {
        case Divide = "/"
        case Multiply = "*"
        case Subtract = "-"
        case Add = "+"
        case Empty = "Empty"
    }
    
    
    //Starts off all calculations with nothing in it.
    var currentOperation = Operation.Empty
    
    //Updates after someone hits an operator (Plus, minus, multi, divide)
    var runningNumber = ""
    
    //Sets up the variables for the numbers:  2(left var) +(operator) 2(Right var) =(operator) 4(result)
    
    var leftVarStr = ""
    var rightVarStr = ""
    var result = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //Every sound file has a path to whatever folder it is housed. Apps are housed in the Bundle that downloads
        let path = Bundle.main.path(forResource: "btn", ofType: "wav")
        let soundURL = URL(fileURLWithPath: path!)
        
        //Error Handling
        do {
            //Try allows us to execute the file and if it doesn't work, doesn't crash the entire app.
            try btnSound = AVAudioPlayer(contentsOf: soundURL, fileTypeHint: path!)
            
            //Queues up the sound to play
            btnSound.prepareToPlay()
        }
            
        //Prints out error message
        catch let err as NSError {
            print(err.debugDescription)
        }
    }
    
        //Connects the buttons to the sound. PlaySound() calls the audio file from the path
        @IBAction func btnPressed(_ sender: UIButton) {
        playSound()
        
        //Displays the number after it has been pressed. We use "sender.tag" from the "_sender" in the button function
        runningNumber += "\(sender.tag)"
        
        //Puts the numbers on the label from runningNumber
        outputLbl.text = runningNumber
    }
    //Sets what happens when you the corresponding button is pressed
    @IBAction func onDividePressed(_sender: AnyObject) {
        processOperation(operation: .Divide)
        
    }
    @IBAction func onMultipledPressed(_sender: AnyObject) {
        processOperation(operation: .Multiply)
    }
    @IBAction func onSubtractPressed(_sender: AnyObject) {
        processOperation(operation: .Subtract)
    }
    @IBAction func onAddPressed(_sender: AnyObject) {
        processOperation(operation: .Add)
        
    }
    @IBAction func onEqualPressed(_sender: AnyObject) {
        processOperation(operation: currentOperation)
        
    }
    
        //Stop the sound so that the app can start a new instance of the sound.
        func playSound(){
        if btnSound.isPlaying {
                btnSound.stop()
                
            }
            // Plays the sound
            btnSound.play()
        }
    
    //This function passes the enum cases to a function. We will have if loops for each operator add and pass data
    func processOperation(operation: Operation) {
        if currentOperation != Operation.Empty { //If There's nothing in the calc...
            
            //If user selected an operator but then selected another operator. "!=" means  "Is equal to"
            if runningNumber != "" {
                rightVarStr = runningNumber
                runningNumber = ""
                
                //Determins what happens when operater buttnons are pressed
                if currentOperation == Operation.Multiply {
                    result = "\(Double(leftVarStr)! * Double(rightVarStr)!)"
                } else if currentOperation == Operation.Divide {
                    result = "\(Double(leftVarStr)! / Double(rightVarStr)!)"
                } else if currentOperation == Operation.Subtract {
                    result = "\(Double(leftVarStr)! - Double(rightVarStr)!)"
                } else if currentOperation == Operation.Add {
                    result = "\(Double(leftVarStr)! + Double(rightVarStr)!)"
                }
                
                //Sets the Output to the label
                leftVarStr = result
                outputLbl.text = result
            }
            //If there is nothing pressed or the format is wrong this will catch the error
            currentOperation = operation
        } else  {
            //This is the first opperator being pressed
            leftVarStr = runningNumber
            runningNumber = ""
            currentOperation = operation
        }
    }
        
}
