//
//  earthViewController.swift
//  CustomTabCenterBig
//
//  Created by Xibo Zhang on 2018/1/21.
//  Copyright © 2018年 Nitin Gohel. All rights reserved.
//

import UIKit
import SceneKit
import SpriteKit

@available(iOS 10.0, *)
class earthViewController: UIViewController {
    var spriteScene: OverlayScene!
    override func viewDidLoad() {
        super.viewDidLoad()
        let scene = SCNScene()
        
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        
        cameraNode.position = SCNVector3(x:0, y: 0.1, z: 6.6)
        scene.rootNode.addChildNode(cameraNode)
        
        
        let cameraOrbit = SCNNode()
        cameraOrbit.addChildNode(cameraNode)
        scene.rootNode.addChildNode(cameraOrbit)
        
        // rotate it (I've left out some animation code here to show just the rotation)
        cameraOrbit.eulerAngles.x =  Float(CGFloat(-1*Double.pi/6 ))
        cameraOrbit.eulerAngles.y = Float(CGFloat(Double.pi / 6))

        

        

        
        let stars = SCNParticleSystem(named: "stars.scnp", inDirectory: nil)!
        scene.rootNode.addParticleSystem(stars)
        
        let earthNode = EarthNode()
        scene.rootNode.addChildNode(earthNode)
    
        

        
        let lightNode2 = SCNNode()
        lightNode2.light = SCNLight()
        lightNode2.light?.type = .omni
        lightNode2.position = SCNVector3(x: 0, y: -10, z: 0)
        // scene.rootNode.addChildNode(lightNode2)
        
        let lightNode3 = SCNNode()
        lightNode3.light = SCNLight()
        lightNode3.light?.type = .omni
        lightNode3.position = SCNVector3(x: 10, y: 0, z: 10)
        
        //scene.rootNode.addChildNode(lightNode3)
        
        let lightNode4 = SCNNode()
        lightNode4.light = SCNLight()
        lightNode4.light?.type = .omni
        lightNode4.position = SCNVector3(x: -10, y: 0, z: -10)
        
        //scene.rootNode.addChildNode(lightNode4)
        
        let lightNode5 = SCNNode()
        lightNode5.light = SCNLight()
        lightNode5.light?.type = .omni
        lightNode5.position = SCNVector3(x: 1, y: 1, z: 500)
         //scene.rootNode.addChildNode(lightNode5)
        let sun:SCNNode
        sun = SCNNode()
        sun.light = SCNLight()
        sun.light?.type = SCNLight.LightType.ambient
        sun.light?.intensity = 100
        
        //scene.rootNode.addChildNode(sun)
        
        let sceneView = self.view as! SCNView
        sceneView.scene = scene
        
        //sceneView.showsStatistics = true
        sceneView.backgroundColor = UIColor.black
        sceneView.allowsCameraControl = true
        
        self.spriteScene = OverlayScene(size: self.view.bounds.size)
        sceneView.overlaySKScene = self.spriteScene
    }

    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
