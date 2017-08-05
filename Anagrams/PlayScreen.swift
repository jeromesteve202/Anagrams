//
//  PlayScreen.swift
//  Anagrams
//
//  Created by Rishi Pochiraju on 7/8/16.
//  Copyright © 2016 SPK Dev. All rights reserved.
//

var targetX = [CGFloat]()
var targetY: CGFloat = 0.0
var tileX = [CGFloat]()
var tileY: CGFloat = 0.0
var answersArray = [Character]()

var targetCenters = [CGPoint]()
var tiles = [TileView]()
var targets = [TargetView]()

import UIKit
import GoogleMobileAds

class PlayScreen: UIViewController {
    
    @IBOutlet weak var bannerView: GADBannerView!
    
    var scrambled = ""
    var solution = ""
    var timer = Timer()
    var checkingTimer = Timer()
    var counter = 0
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        loadTiles()
        
    }
    
    func loadTiles() {
        
        if (UIDeviceOrientationIsLandscape(UIDevice.current.orientation)){
            print("landscape")
        }
        
        for x in self.view.subviews {
            if x != bannerView {
                x.removeFromSuperview()
            }
        }
        
        let screenHeight = Double(self.view.frame.size.height)
        let screenWidth = Double(self.view.frame.size.width)
        
        var width90 = 0.9 * screenWidth
        var lettersDistance = width90 / Double(actualWords[indexSelected].characters.count)
        var addEveryTime = width90 / Double(actualWords[indexSelected].characters.count)
        var lettersWidth = CGFloat(0.9 * lettersDistance)
        
        answersArray.removeAll()
        targetX.removeAll()
        targetY = 0.0
        tileX.removeAll()
        tileY = 0.0
        
        let count = actualWords[indexSelected].characters.count
        for char in scrambledWords[indexSelected].characters{
            let tile = TileView(letter: char, sideLength: lettersWidth)
            if (count == 3){
                tile.center = CGPoint(x: CGFloat(lettersDistance - width90 * 0.111), y: CGFloat(screenHeight/4*3))
            }else if (count == 4){
                tile.center = CGPoint(x: CGFloat(lettersDistance - width90 * 0.074), y: CGFloat(screenHeight/4*3))
            }else if (count == 5){
                tile.center = CGPoint(x: CGFloat(lettersDistance - width90 * 0.049), y: CGFloat(screenHeight/4*3))
            }else if (count == 6){
                tile.center = CGPoint(x: CGFloat(lettersDistance - width90 * 0.027), y: CGFloat(screenHeight/4*3))
            }else if (count == 7){
                tile.center = CGPoint(x: CGFloat(lettersDistance - width90 * 0.012), y: CGFloat(screenHeight/4*3))
            }else if (count == 8){
                tile.center = CGPoint(x: CGFloat(lettersDistance - width90 * 0.0098), y: CGFloat(screenHeight/4*3))
            }else if (count == 9){
                tile.center = CGPoint(x: CGFloat(lettersDistance - width90 * 0.0068), y: CGFloat(screenHeight/4*3))
            }else if (count == 10){
                tile.center = CGPoint(x: CGFloat(lettersDistance - width90 * 0.0035), y: CGFloat(screenHeight/4*3))
            }else if (count == 11){
                tile.center = CGPoint(x: CGFloat(lettersDistance - width90 * 0.0001), y: CGFloat(screenHeight/4*3))
            }else if (count == 12){
                tile.center = CGPoint(x: CGFloat(lettersDistance - width90 * 0.0000723), y: CGFloat(screenHeight/4*3))
            }else if (count == 13){
                tile.center = CGPoint(x: CGFloat(lettersDistance - width90 * 0.00003), y: CGFloat(screenHeight/4*3))
            }else if (count == 14){
                tile.center = CGPoint(x: CGFloat(lettersDistance - width90 * 0.0000008), y: CGFloat(screenHeight/4*3))
            }else if (count == 15){
                tile.center = CGPoint(x: CGFloat(lettersDistance), y: CGFloat(screenHeight/4*3))
            }else if (count == 16){
                tile.center = CGPoint(x: CGFloat(lettersDistance), y: CGFloat(screenHeight/4*3))
            }
            
            tiles.append(tile)
            tile.dragDelegate = self
            self.view.addSubview(tile)
            lettersDistance += addEveryTime
        }
        
        width90 = 0.9 * screenWidth
        lettersDistance = width90 / Double(actualWords[indexSelected].characters.count)
        addEveryTime = width90 / Double(actualWords[indexSelected].characters.count)
        lettersWidth = CGFloat(0.9 * lettersDistance)
        
        targetCenters.removeAll()
        for char in actualWords[indexSelected].characters{
            let target = TargetView(letter: char, sideLength: lettersWidth)
            answersArray.append(char)
            if (count == 3){
                target.center = CGPoint(x: CGFloat(lettersDistance - width90 * 0.111), y: CGFloat(screenHeight * 0.4))
            }else if (count == 4){
                target.center = CGPoint(x: CGFloat(lettersDistance - width90 * 0.074), y: CGFloat(screenHeight * 0.4))
            }else if (count == 5){
                target.center = CGPoint(x: CGFloat(lettersDistance - width90 * 0.049), y: CGFloat(screenHeight * 0.4))
            }else if (count == 6){
                target.center = CGPoint(x: CGFloat(lettersDistance - width90 * 0.027), y: CGFloat(screenHeight * 0.4))
            }else if (count == 7){
                target.center = CGPoint(x: CGFloat(lettersDistance - width90 * 0.012), y: CGFloat(screenHeight * 0.4))
            }else if (count == 8){
                target.center = CGPoint(x: CGFloat(lettersDistance - width90 * 0.0098), y: CGFloat(screenHeight * 0.4))
            }else if (count == 9){
                target.center = CGPoint(x: CGFloat(lettersDistance - width90 * 0.0068), y: CGFloat(screenHeight * 0.4))
            }else if (count == 10){
                target.center = CGPoint(x: CGFloat(lettersDistance - width90 * 0.0035), y: CGFloat(screenHeight * 0.4))
            }else if (count == 11){
                target.center = CGPoint(x: CGFloat(lettersDistance - width90 * 0.0001), y: CGFloat(screenHeight * 0.4))
            }else if (count == 12){
                target.center = CGPoint(x: CGFloat(lettersDistance - width90 * 0.0000723), y: CGFloat(screenHeight * 0.4))
            }else if (count == 13){
                target.center = CGPoint(x: CGFloat(lettersDistance - width90 * 0.00003), y: CGFloat(screenHeight * 0.4))
            }else if (count == 14){
                target.center = CGPoint(x: CGFloat(lettersDistance - width90 * 0.0000008), y: CGFloat(screenHeight * 0.4))
            }else if (count == 15){
                target.center = CGPoint(x: CGFloat(lettersDistance), y: CGFloat(screenHeight * 0.4))
            }else if (count == 16){
                target.center = CGPoint(x: CGFloat(lettersDistance), y: CGFloat(screenHeight * 0.4))
            }
            
            targets.append(target)
            targetCenters.append(target.center)
            targetX.append(target.center.x)
            targetY = target.center.y
            self.view.addSubview(target)
            lettersDistance += addEveryTime
        }
        
    }
    
    func rotate(){
        if (UIDeviceOrientationIsLandscape(UIDevice.current.orientation)){
            print("landscape")
        }
    
        if (UIDeviceOrientationIsPortrait(UIDevice.current.orientation)) {
            print("Portrait")
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initializeViewDidLoad()
        
        checkingTimer = Timer.scheduledTimer(timeInterval: 0.001, target: self, selector: #selector(updateCheckingTimer), userInfo: nil, repeats: true)
        
        let bannerView2 = GADBannerView()
        
        print("Google Mobile Ads SDK version: " + GADRequest.sdkVersion())
        bannerView2.adUnitID = "ca-app-pub-2830059983414219/9100025485"
        bannerView2.rootViewController = self
        bannerView2.load(GADRequest())
        
        bannerView2.frame = CGRect(x: 0.0, y: self.view.frame.size.height - 50, width: self.view.frame.size.width, height: 50.0)
        bannerView = bannerView2
        self.view.addSubview(bannerView)
        
        

        // Do any additional setup after loading the view.
        
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator);
        coordinator.animate(alongsideTransition: nil, completion: {
            _ in
            
            self.loadTiles()
            
        })
    }
    
    func initializeViewDidLoad(){
        
        for x in self.view.subviews {
            if x != bannerView {
                x.removeFromSuperview()
            }
        }
        
        isPlaying = true
        
        scrambled = scrambledWords[indexSelected]
        solution = actualWords[indexSelected]
        
        self.navigationItem.title = "LEVEL \(indexSelected + 1)"
    }
    
    func updateCheckingTimer(){
        if (gameWon == true){
            gameWon = false
            checkAcrossScreen()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func placeTile(_ tileView: TileView, targetView: TargetView) {

        targetView.isMatched = true
        tileView.isMatched = true
        
    }
    
    func checkAcrossScreen(){
        timer = Timer.scheduledTimer(timeInterval: 0.25, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    func updateTimer(){
        
        counter += 1
        
        let imageName = "checkmark.png"
        let image = UIImage(named: imageName)
        let imageView = UIImageView(image: image!)
        imageView.frame = CGRect(x: self.view.frame.size.width/2 - 40, y: self.view.frame.size.height / 6.5, width: 100.0, height: 100.0)
        self.view?.addSubview(imageView)
        
        print("PUTTING CHECK MARK")
        
        if (counter >= 4){
            timer.invalidate()
            counter = 0
            imageView.removeFromSuperview()
            resetScene()
        }
        
    }
    
    func resetScene(){
        tiles.removeAll()
        targets.removeAll()
        targetCenters.removeAll()
        targetX.removeAll()
        tileX.removeAll()
        tileY = 0
        answersArray.removeAll()
        
        for x in self.view.subviews {
            print("iam trying to remove views")
            if x != bannerView {
                self.view.willRemoveSubview(x)
                print("removed the view ")
            }
        }
        
        indexSelected += 1
        
        if (userLevel < indexSelected + 1){
            userLevel = indexSelected + 1
        }
        
        initializeViewDidLoad()
        loadTiles()
    }
    
}


extension PlayScreen:TileDragDelegateProtocol {
    //a tile was dragged, check if matches a target
    func tileView(_ tileView: TileView, didDragToPoint point: CGPoint) {
                
    }
    
    
}


