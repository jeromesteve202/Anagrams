//
//  TileView.swift
//  Anagrams
//
//  Created by Rishi Pochiraju on 7/16/16.
//  Copyright © 2016 SPK Dev. All rights reserved.
//

var gameWon = false

import UIKit

protocol TileDragDelegateProtocol {
    func tileView(_ tileView: TileView, didDragToPoint: CGPoint)
}

class TileView: UIImageView {
    
    fileprivate var xOffset: CGFloat = 0.0
    fileprivate var yOffset: CGFloat = 0.0
    
    var dragDelegate: TileDragDelegateProtocol?
    
    var letter: Character
    
    var isMatched: Bool = false
    
    required init(coder aDecoder:NSCoder) {
        fatalError("use init(letter:, sideLength:")
    }
    
    //5 create a new tile for a given letter
    init(letter:Character, sideLength:CGFloat) {
        self.letter = letter
        
        //the tile background
        let image = UIImage(named: "tile")!
        
        //superclass initializer
        //references to superview's "self" must take place after super.init
        super.init(image:image)
        
        //6 resize the tile
        let scale = sideLength / image.size.width
        self.frame = CGRect(x: 0, y: 0, width: image.size.width * scale, height: image.size.height * scale)
        
        //more initialization here
        
        let letterLabel = UILabel(frame: self.bounds)
        letterLabel.textAlignment = NSTextAlignment.center
        letterLabel.textColor = UIColor.white
        letterLabel.backgroundColor = UIColor.clear
        letterLabel.text = String(letter).uppercased()
        letterLabel.font = UIFont(name: "Avenir", size: 78.0*scale)
        self.addSubview(letterLabel)
        
        self.isUserInteractionEnabled = true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let point = touch.location(in: self.superview)
            xOffset = point.x - self.center.x
            yOffset = point.y - self.center.y
        }
    }
    
    //2
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let point = touch.location(in: self.superview)
            self.center = CGPoint(x: point.x - xOffset, y: point.y - yOffset)

        }
    }
    
    //3
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.touchesMoved(touches, with: event)
        dragDelegate?.tileView(self, didDragToPoint: self.center)
        
        let tileCenterX = self.center.x
        let tileCenterY = self.center.y
        
        for i in 0...targetX.count {
            if (targets.count <= 6){
                if (((tileCenterX - targetX[i] <= 43) && (tileCenterY - targetY <= 43)) || ((tileCenterX + targetX[i] <= 43) && (tileCenterY - targetY <= 43)) || ((tileCenterX - targetX[i] <= 43) && (tileCenterY + targetY <= 43)) || ((tileCenterX + targetX[i] <= 43) && (tileCenterY + targetY <= 43))){
                    self.center = CGPoint(x: targetX[i], y: targetY)
                    break
                }
            }else{
                if (((tileCenterX - targetX[i] <= 23) && (tileCenterY - targetY <= 23)) || ((tileCenterX + targetX[i] <= 23) && (tileCenterY - targetY <= 23)) || ((tileCenterX - targetX[i] <= 23) && (tileCenterY + targetY <= 23)) || ((tileCenterX + targetX[i] <= 23) && (tileCenterY + targetY <= 23))){
                    self.center = CGPoint(x: targetX[i], y: targetY)
                    break
                }
            }
        }
        
        var isAligned = false
        for i in 0...tiles.count {
            if (tiles[i].center.y == targets[i].center.y){
                isAligned = true
            }else{
                isAligned = false
                break
            }
            
        }
        
        if (isAligned == true){
            for i in 0 ... tiles.count{
                for j in i + 1 ... tiles.count {
                    if (tiles[i].center.x > tiles[j].center.x){
                        let savedTile = tiles[i]
                        tiles[i] = tiles[j]
                        tiles[j] = savedTile
                    }
                }
            }
            
        }
        
        var resultStr = ""
        for i in 0 ... tiles.count {
            resultStr += String(tiles[i].letter)
        }
        
        if (resultStr == actualWords[indexSelected]){
            gameWon = true
            for i in 0 ... tiles.count {
                tiles[i].isUserInteractionEnabled = false
            }
        }
        
        
    }
    
}
