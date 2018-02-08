//
//  OverlayScene.swift
//  CustomTabCenterBig
//
//  Created by Xibo Zhang on 2018/1/23.
//  Copyright © 2018年 Nitin Gohel. All rights reserved.
//

import UIKit
import SpriteKit

class OverlayScene: SKScene {
    
    //var pauseNode: SKSpriteNode!
    var scoreNode: SKLabelNode!
    
    var score = 0 {
        didSet {
            //self.scoreNode.text = "Score: \(self.score)"
            
            let currentDateTime = Date()
            
            // initialize the date formatter and set the style
            let formatter = DateFormatter()
            formatter.timeStyle = .medium
            formatter.dateStyle = .none
            
            
            
            // get the date time String from the date object
            
            self.scoreNode.text = "\(formatter.string(from: currentDateTime))"
            //self.scoreNode.text = "\(Date())"
            
            /*
            let dateAsString = "\(formatter.string(from: currentDateTime))"
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "h:mm:ss a"
            let date = dateFormatter.date(from: dateAsString)
            
            dateFormatter.dateFormat = "HH:mm:ss"
            let date24 = dateFormatter.string(from: date!)
            self.scoreNode.text = date24
 */
        }
    }
    
    override init(size: CGSize) {
        super.init(size: size)
        
        self.backgroundColor = UIColor.clear
        
        self.scoreNode = SKLabelNode(text: "你好！")
        self.scoreNode.fontName = "Arial-BoldItalicMT"//1"ArialRoundedMTBold"//A"DBLCDTempBlack"//2"Helvetica-BoldOblique"//1"Arial-BoldItalicMT"//"Kohinoor Telugu-bold"//Heiti SC //Copperplate
        self.scoreNode.fontColor = UIColor.white
        self.scoreNode.fontSize = 26
        self.scoreNode.position = CGPoint(x: size.width/2, y:  size.height - 105)
        
        self.addChild(self.scoreNode)
        

    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func update(_ currentTime: TimeInterval)
    {
        let wait = SKAction.wait(forDuration: 1.5)
        let run = SKAction.run {
            self.score = self.score + 1
        }
        self.run(SKAction.sequence([wait, run]))
    }

}
