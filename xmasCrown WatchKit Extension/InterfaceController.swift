//
//  InterfaceController.swift
//  xmasCrown WatchKit Extension
//
//  Created by Y.T. Hoshino on 2016/12/09.
//  Copyright © 2016年 Yuta Hoshino. All rights reserved.
//

import WatchKit
import Foundation

class InterfaceController: WKInterfaceController, WKCrownDelegate {
    
    @IBOutlet var sceneView: WKInterfaceSCNScene!
    
    var brownNode = SCNNode(geometry: SCNCylinder(radius: 1, height: 1))
    var greenNode = SCNNode(geometry: SCNPyramid(width: 5, height: 7.5, length: 5))
    var ringNode = SCNNode(geometry: SCNTorus(ringRadius: 1, pipeRadius: 0.2))
    
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        crownSequencer.delegate = self
        addScene()
        
    }
    
    func addScene() {
        let scene = SCNScene()
        
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        scene.rootNode.addChildNode(cameraNode)
        
        cameraNode.position = SCNVector3(x: 0, y: 0, z: 15)
        
        let lightNode = SCNNode()
        lightNode.light = SCNLight()
        lightNode.light!.type = SCNLight.LightType.omni
        lightNode.position = SCNVector3(x: 0, y: 10, z: 10)
        scene.rootNode.addChildNode(lightNode)
        
        let ambientLightNode = SCNNode()
        ambientLightNode.light = SCNLight()
        ambientLightNode.light!.type = SCNLight.LightType.ambient
        ambientLightNode.light!.color = UIColor.darkGray
        scene.rootNode.addChildNode(ambientLightNode)
        
        brownNode.position = SCNVector3(x: 0, y: -2.5, z: 0)
        greenNode.position = SCNVector3(x: 0, y: -2, z: 0)
        ringNode.position = SCNVector3(x: 0, y: 5.5, z: 0)
        
        //texture
        let material = SCNMaterial()
        material.diffuse.contents = UIColor(red:0.27, green:0.68, blue:0.35, alpha:1.0)
        greenNode.geometry?.firstMaterial = material
        
        let material2 = SCNMaterial()
        material2.diffuse.contents = UIColor.yellow
        ringNode.geometry?.firstMaterial = material2
        
        let material3 = SCNMaterial()
        material3.diffuse.contents = UIColor.brown
        brownNode.geometry?.firstMaterial = material3
        
        scene.rootNode.addChildNode(brownNode)
        scene.rootNode.addChildNode(greenNode)
        scene.rootNode.addChildNode(ringNode)
        
        sceneView.scene = scene
        
        //If you want to see fps, please uncomment it.
        //        sceneView.showsStatistics = true
        
    }
    override func willActivate() {
        super.willActivate()
        crownSequencer.focus()
        
    }
    
    func crownDidRotate(_ crownSequencer: WKCrownSequencer?, rotationalDelta: Double) {
        
        let d:CGFloat = CGFloat(rotationalDelta)
        greenNode.runAction(SCNAction.rotateBy(x: 0, y: d, z: 0, duration: 0.5), completionHandler: {} )
        
    }
    
    override func didDeactivate() {
        super.didDeactivate()
    }
    
}
