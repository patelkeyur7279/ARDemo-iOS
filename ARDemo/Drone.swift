//
//  Drone.swift
//  ARDemo
//
//  Created by mac on 19/08/19.
//  Copyright © 2019 Knackgen. All rights reserved.
//

import Foundation
import ARKit

class Drone: SCNNode {
    
    func loadModel() {
        
        print("Drone Load Init.....")
        
        guard let virtualObjectScene = SCNScene(named: "Drone.scn") else { return }
        
        let wrapperNode = SCNNode()
        
        for child in virtualObjectScene.rootNode.childNodes {
            print("Child -----------> \(child)")
            wrapperNode.addChildNode(child)
        }
        
        addChildNode(wrapperNode)
        
        print("Drone Load Completed.....")
        
    }
    
}
