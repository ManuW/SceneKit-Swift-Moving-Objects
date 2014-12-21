//
//  GameView.swift
//  SceneKit Swift Moving Objects
//
//  Created by Manuel Wentenschuh on 21.Dec.14.
//  example code
//

import SceneKit


func round(val: SCNVector3) -> SCNVector3 {
    return SCNVector3(x: round(val.x), y: round(val.y), z: round(val.z))
}


func + (left: SCNVector3, right: SCNVector3) -> SCNVector3 {
    return SCNVector3(x: left.x + right.x, y: left.y + right.y, z: left.z + right.z)
}

func - (left: SCNVector3, right: SCNVector3) -> SCNVector3 {
    return SCNVector3(x: left.x - right.x, y: left.y - right.y, z: left.z - right.z)
}

func * (left: SCNVector3, right: SCNVector3) -> CGFloat {
    return CGFloat(left.x * right.x + left.y * right.y + left.z * right.z)
}


func * (left: SCNVector3, right: CGFloat) -> SCNVector3 {
    return SCNVector3(x: left.x * right, y: left.y * right, z: left.z * right)
}

func * (left: CGFloat, right: SCNVector3) -> SCNVector3 {
    return SCNVector3(x: left * right.x, y: left * right.y, z: left * right.z)
}


class GameView: SCNView {
    
    var mark : SCNNode? = nil
    var selection : SCNHitTestResult? = nil
    var hitOld = SCNVector3Zero
    
    // mark an object (= selection)
    override func mouseDown(theEvent: NSEvent) {
        
        let p = self.convertPoint(theEvent.locationInWindow, fromView: nil)
        let options = [SCNHitTestSortResultsKey : NSNumber(bool: true), SCNHitTestBoundingBoxOnlyKey : NSNumber(bool: true)]
        
        if let hitResults = self.hitTest(p, options: options) {
        
            if (hitResults.count > 0){
                let result: AnyObject = hitResults[0]
                if  result is SCNHitTestResult {
                    selection = result as? SCNHitTestResult
                }
            }
        }
        
        super.mouseDown(theEvent)
    }
    
    
    // if there is a marked object, clone it and move it
    override func mouseDragged(theEvent: NSEvent) {
        
        if selection != nil {
            let mouse   = self.convertPoint(theEvent.locationInWindow, fromView: self)
            var unPoint = unprojectPoint(SCNVector3(x: mouse.x, y: mouse.y, z: 0.0))
            let p1      = selection!.node.parentNode!.convertPosition(unPoint, fromNode: nil)
            unPoint = unprojectPoint(SCNVector3(x: mouse.x, y: mouse.y, z: 1.0))
            let p2      = selection!.node.parentNode!.convertPosition(unPoint, fromNode: nil)
            let m       = p2 - p1
            
            let e       = selection!.localCoordinates
            let n       = selection!.localNormal
            
            let t       = ((e * n) - (p1 * n)) / (m * n)
            var hit     = SCNVector3(x: p1.x + t * m.x, y: p1.y + t * m.y, z: p1.z + t * m.z)
            let offset  = hit - hitOld
            hitOld      = hit
            
            if mark != nil {
                mark!.position = mark!.position + offset
                
            } else {
                mark = selection!.node.clone() as? SCNNode
                mark!.opacity = 0.333
                mark!.position = selection!.node.position
                selection!.node.parentNode!.addChildNode(mark!)
            }
            
        } else {
            super.mouseDragged(theEvent)
        }
    }
    
    
    //   when the mouse button is released
    // + an object was marked
    // + the CRTL button is pressed
    // = copy the object (means: don't remove the cloned object)
    override func mouseUp(theEvent: NSEvent) {
        
        if selection != nil {
            
            if theEvent.modifierFlags == NSEventModifierFlags.ControlKeyMask {
                mark!.opacity = 1.0
                
            } else {
                selection!.node.position = selection!.node.convertPosition(mark!.position, fromNode: selection!.node)
                mark!.removeFromParentNode()
            }
            
            selection = nil
            mark = nil
            
        } else {
            super.mouseUp(theEvent)
        }
    }
    
}