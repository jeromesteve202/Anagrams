//
//  ViewController.swift
//  Anagrams
//
//  Created by Rishi Pochiraju on 7/6/16.
//  Copyright © 2016 SPK Dev. All rights reserved.
//

import UIKit

var actualWords = [String]()
var scrambledWords = [String]()
var userLevel = 1
var wentInside = false

let defaults = UserDefaults.standard

class PreScreen: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        getWordsFromTextFiles()
        
        //eliminate words that didn't get scrambled
        for i in 0...actualWords.count {
            if (actualWords[i] == scrambledWords[i]){
                actualWords.remove(at: i)
                scrambledWords.remove(at: i)
            }
        }
        
        if wentInside == false {
            if defaults.object(forKey: "level") != nil {
                userLevel = defaults.object(forKey: "level") as! NSInteger

            }
        }
        
        createStartButton()

    }
    
    func createStartButton(){
        let start: UIButton = UIButton(frame: CGRect(x: 0, y: self.view.frame.size.height * 4.2 / 5, width: self.view.frame.size.width, height: 15))
        start.setTitle("Click here or click the play image to start playing", for: UIControlState())
        start.titleLabel?.font = UIFont(name: "Avenir", size: 13)
        start.titleLabel?.textAlignment = .center
        start.setTitleColor(UIColor(red: 73/255.0, green: 181/255.0, blue: 22/255.0, alpha: 1.0), for: UIControlState())
        start.addTarget(self, action: #selector(PreScreen.buttonAction(_:)), for: UIControlEvents.touchUpInside)
        self.view.addSubview(start)
    }
    
    func buttonAction(_ sender: UIButton){
        performSegue(withIdentifier: "goToTable", sender: sender)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getWordsFromTextFiles(){
        let fileName = "Unscrambled.txt"
        let path = Bundle.main.path(forResource: fileName, ofType: nil)
        if path == nil {
            print("nil")
        }
        
        var fileContents: String? = nil
        do {
            fileContents = try String(contentsOfFile: path!, encoding: String.Encoding.utf8)
        } catch _ as NSError {
            print("nil")
        }
        
        actualWords = (fileContents?.components(separatedBy: "\n"))!
        
        
        let fileName2 = "Scrambled.txt"
        let path2 = Bundle.main.path(forResource: fileName2, ofType: nil)
        if path2 == nil {
            print("nil")
        }
        
        var fileContents2: String? = nil
        do {
            fileContents2 = try String(contentsOfFile: path2!, encoding: String.Encoding.utf8)
        } catch _ as NSError {
            print("nil")
        }
        
        scrambledWords = (fileContents2?.components(separatedBy: "\n"))!
    }
    
    
}

