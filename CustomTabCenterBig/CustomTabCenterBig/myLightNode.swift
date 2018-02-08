//
//  myLightNode.swift
//  CustomTabCenterBig
//
//  Created by Xibo Zhang on 2018/1/21.
//  Copyright © 2018年 Nitin Gohel. All rights reserved.
//
import SceneKit

@available(iOS 10.0, *)
class myLightNode: SCNNode {
    override init() {
        super.init()
        
        
        let date = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        let minutes = calendar.component(.minute, from: date)
        
        
        let time_now =  Float(hour) + Float(minutes)/60 - 12.0
        let delta_angle = Float(time_now / 12.0 ) * Float(Double.pi)
        
        let x_test = 1077.03 * cos( atan(-400/1000) + delta_angle)
        let z_test = 1077.03 * sin( atan(-400/1000) + delta_angle)

        
        let lightNode = SCNNode()
        lightNode.light = SCNLight()
        lightNode.light?.type = .omni
        lightNode.position = SCNVector3(x: Float(x_test), y: 300, z: Float(z_test))
        lightNode.light?.intensity = 3000
        lightNode.eulerAngles = SCNVector3Make(Float(Double.pi/2),0, 0);
        
        self.addChildNode(lightNode)
        
        let action = SCNAction.rotate(by: -360 * CGFloat(Double.pi / 180), around: SCNVector3(x:2, y:10, z:0), duration: 24*60*60)
        
        let repeatAction = SCNAction.repeatForever(action)
        
        self.runAction(repeatAction)
        //let lightNode = SCNLight()
        //lightNode.light = SCNLight()
        //lightNode.light?.type = .omni
        //lightNode.light?.intensity = 2220
        //self.light = SCNLight()
        //self.light?.type = .omni
        //self.light?.intensity = 2220
        
        //self.position = SCNVector3(x: 0, y: 2, z:0)
        
        
        
        
        //self.pivot = SCNMatrix4MakeRotation(Float(CGFloat(M_PI_2)), 1, 0, 0)
        
        /*
        
        let action = SCNAction.rotate(by: 360 * CGFloat(Double.pi / 180), around: SCNVector3(x:0, y:1, z:1), duration: 1)
        
        //let repeatAction = SCNAction.repeatForever(action)
        
        //self.runAction(repeatAction)
        //let actionTest = SCNAction.moveBy(x: 2, y: 2, z: 0, duration: 1.0)
        //let repeatActionTest = SCNAction.repeatForever(actionTest)
        //self.runAction(repeatActionTest)
        
        let moveUp = SCNAction.moveBy(x: 0, y: 1, z: 0, duration: 1)
        moveUp.timingMode = .easeInEaseOut;
        let moveDown = SCNAction.moveBy(x: 0, y: -1, z: 0, duration: 1)
        moveDown.timingMode = .easeInEaseOut;
        let moveSequence = SCNAction.sequence([moveUp,moveDown])
        let moveLoop = SCNAction.repeatForever(moveSequence)
        //self.runAction(moveLoop)
        
        let rotate = SCNAction.rotateBy(x: 0, y: .pi, z: 0, duration: 2)
        let repeatAction = SCNAction.repeatForever(rotate)
        
        self.runAction(repeatAction)
 */
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    
  
}

