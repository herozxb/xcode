//
//  EarthNode.swift
//  3dEarth
//
//  Created by Brian Advent on 03.12.17.
//  Copyright © 2017 Brian Advent. All rights reserved.
//

import SceneKit

@available(iOS 10.0, *)
class EarthNode: SCNNode {
    
    override init() {
        super.init()
        self.geometry = SCNSphere(radius: 1.5)
        self.geometry?.firstMaterial?.diffuse.contents = UIImage(named:"Diffuse")
        self.geometry?.firstMaterial?.specular.contents = UIImage(named:"Specular")
        self.geometry?.firstMaterial?.emission.contents = UIImage(named:"Emission")
        //self.geometry?.firstMaterial?.normal.contents = UIImage(named:"Normal")
        
        //let earth = SCNSphere(radius: 1)
        //let earthNode = SCNNode()
        
        /*
        let lightNode = SCNNode()
        lightNode.light = SCNLight()
        lightNode.light?.type = .omni
        lightNode.position = SCNVector3(x: 0, y: 10, z: 5)

        
        let earthMaterial = SCNMaterial()
        earthMaterial.diffuse.contents = UIImage(named: "Diffuse.jpg")
        //earthMaterial.emission.contents = UIImage(named: "Emission.png")
        self.geometry?.materials = [earthMaterial]
        
        let emissionTexture = UIImage(named: "Emission.jpg")!
        let emission = SCNMaterialProperty(contents: emissionTexture)
        earthMaterial.setValue(emission, forKey: "emissionTexture")
        */
/*
        let shaderModifier =
        """
uniform sampler2D emissionTexture;

vec3 light = Vec3(x: 0, y: 10, z: 0);
float lum = max(0.0, 1 - (0.2126*light.r + 0.7152*light.g + 0.0722*light.b));
vec4 emission = texture2D(emissionTexture, _surface.diffuseTexcoord) * lum;
_output.color += emission;
"""
        earthMaterial.shaderModifiers = [.fragment: shaderModifier]
 */
        
        
        
        
        
        
        self.geometry?.firstMaterial?.shininess = 30
        
        let lightNode = myLightNode()
        
        self.addChildNode(lightNode)
        
        
        let action = SCNAction.rotate(by: 360 * CGFloat(Double.pi / 180), around: SCNVector3(x:0, y:1, z:0), duration: 20)
        
        let repeatAction = SCNAction.repeatForever(action)
        
        self.runAction(repeatAction)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    
}

