//
//  GameScene.swift
//  SceneKit Swift Moving Objects
//
//  Created by Manuel Wentenschuh on 21.Dec.14.
//  example code
//

import Foundation
import SceneKit
import QuartzCore


class GameScene : SCNScene {
    
    override init() {
        super.init()
        
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        cameraNode.position = SCNVector3(x: 0, y: 0, z: 4)
        rootNode.addChildNode(cameraNode)
        
        let helloWorld = "Hello World!"
        var xPos = CGFloat(-5.0)
        let font = NSFont(name: "Menlo", size: 1.0)
        
        for character in helloWorld {
            
            let s = String(character)
            let geo = SCNText(string: s, extrusionDepth: 0.25)
            geo.font = font
            
            let mat     = SCNMaterial()
            let hue : Double = Double(rand()) / Double(RAND_MAX)
            mat.diffuse.contents = NSColor(calibratedHue: CGFloat(hue), saturation: 1.0, brightness: 1.0, alpha: 1.0)
            geo.materials = [mat]
            
            let node = SCNNode(geometry: geo)
            node.position = SCNVector3(x: xPos, y: 0.0, z: 0.0)
            rootNode.addChildNode(node)
            
            xPos += 0.66
        }
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}