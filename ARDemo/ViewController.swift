//
//  ViewController.swift
//  ARDemo
//
//  Created by mac on 19/08/19.
//  Copyright © 2019 Knackgen. All rights reserved.
//

import UIKit
import ARKit

class ViewController: UIViewController {

    @IBOutlet weak var mARScnViewKit: ARSCNView!
    
    @IBOutlet weak var rightUpButton: UIButton!
    @IBOutlet weak var rightRightButton: UIButton!
    @IBOutlet weak var rightLeftButton: UIButton!
    @IBOutlet weak var rightBottomButton: UIButton!
    
    @IBOutlet weak var leftUpButton: UIButton!
    @IBOutlet weak var leftRightButton: UIButton!
    @IBOutlet weak var leftLeftButton: UIButton!
    @IBOutlet weak var leftBottomButton: UIButton!
    
    let drone = Drone()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupScene()
        
        let upRightActionButtonGestures = UILongPressGestureRecognizer(target: self, action: #selector(upRightActionButton))
        let downRightActionButtonGestures = UILongPressGestureRecognizer(target: self, action: #selector(downRightActionButton))
        let leftRightActionButtonGestures = UILongPressGestureRecognizer(target: self, action: #selector(leftRightActionButton))
        let rightRightActionButtonGestures = UILongPressGestureRecognizer(target: self, action: #selector(rightRightActionButton))
        
        rightUpButton.addGestureRecognizer(upRightActionButtonGestures)
        rightRightButton.addGestureRecognizer(rightRightActionButtonGestures)
        rightLeftButton.addGestureRecognizer(leftRightActionButtonGestures)
        rightBottomButton.addGestureRecognizer(downRightActionButtonGestures)
        
        let upLeftActionButtonGestures = UILongPressGestureRecognizer(target: self, action: #selector(upLeftActionButton))
        let downLeftActionButtonGestures = UILongPressGestureRecognizer(target: self, action: #selector(downLeftActionButton))
        let leftLeftActionButtonGestures = UILongPressGestureRecognizer(target: self, action: #selector(leftLeftActionButton))
        let rightLeftActionButtonGestures = UILongPressGestureRecognizer(target: self, action: #selector(rightLeftActionButton))
        
        leftUpButton.addGestureRecognizer(upLeftActionButtonGestures)
        leftRightButton.addGestureRecognizer(rightLeftActionButtonGestures)
        leftLeftButton.addGestureRecognizer(leftLeftActionButtonGestures)
        leftBottomButton.addGestureRecognizer(downLeftActionButtonGestures)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupConfigration()
    }
    
    func setupScene() {
        let scene = SCNScene()
        mARScnViewKit.scene = scene
    }

    func setupConfigration() {
        let configation = ARWorldTrackingConfiguration()
        mARScnViewKit.session.run(configation)
        addDrone()
    }
    
    func addDrone() {
        
        drone.loadModel()
        mARScnViewKit.scene.rootNode.addChildNode(drone)
        
    }
    
    let kMoveingLengthPerLoop : CGFloat = 0.05
    let kRotationRadianPerLoop : CGFloat = 0.2
    let kAnimationDurationMoving = 0.1
    
    // Right Controls
    
    @IBAction func upRightActionButton(_ sender: UILongPressGestureRecognizer) {
        
        let action = SCNAction.moveBy(x: 0, y: kMoveingLengthPerLoop, z: 0, duration: kAnimationDurationMoving)
        excecute(action: action, sender: sender)
        
    }
    
    func excecute(action: SCNAction, sender: UILongPressGestureRecognizer) {
        
        let loopAction = SCNAction.repeatForever(action)
        if sender.state == .began {
            drone.runAction(loopAction)
        } else if sender.state == .ended {
            drone.removeAllActions()
        }
        
    }
    
    @objc func downRightActionButton(_ sender: UILongPressGestureRecognizer) {
        let action = SCNAction.moveBy(x: 0, y: -kMoveingLengthPerLoop, z: 0, duration: kAnimationDurationMoving)
        excecute(action: action, sender: sender)
    }
    
    @objc func leftRightActionButton(_ sender: UILongPressGestureRecognizer) {
        
        let x = -deltas().cos
        let z = deltas().sin
        moveDrone(x: x, z: z, sender: sender)
        
    }
    
    @objc func rightRightActionButton(_ sender: UILongPressGestureRecognizer) {
        
        let x = deltas().cos
        let z = -deltas().sin
        moveDrone(x: x, z: z, sender: sender)
        
    }
    
    private func deltas() -> (sin: CGFloat, cos: CGFloat) {
        return (sin: kMoveingLengthPerLoop * CGFloat(sin(drone.eulerAngles.y)), cos: kMoveingLengthPerLoop * CGFloat(cos(drone.eulerAngles.y)))
    }
    
    private func moveDrone(x: CGFloat, z: CGFloat, sender: UILongPressGestureRecognizer) {
        let action = SCNAction.moveBy(x: x, y: 0, z: z, duration: kAnimationDurationMoving)
        excecute(action: action, sender: sender)
    }
    
    // Left Controls
    
    @objc func upLeftActionButton(_ sender: UILongPressGestureRecognizer) {
        
        let x = -deltas().sin
        let z = -deltas().cos
        moveDrone(x: x, z: z, sender: sender)
        
    }
    
    @objc func downLeftActionButton(_ sender: UILongPressGestureRecognizer) {
        
        let x = deltas().sin
        let z = deltas().cos
        moveDrone(x: x, z: z, sender: sender)
        
    }
    
    @objc func leftLeftActionButton(_ sender: UILongPressGestureRecognizer) {
        
        rotateDrone(yRadian: kRotationRadianPerLoop, sender: sender)
        
    }
    
    private func rotateDrone(yRadian: CGFloat, sender: UILongPressGestureRecognizer) {
        let action = SCNAction.rotateBy(x: 0, y: yRadian, z: 0, duration: kAnimationDurationMoving)
        excecute(action: action, sender: sender)
    }
    
    @objc func rightLeftActionButton(_ sender: UILongPressGestureRecognizer) {
        rotateDrone(yRadian: -kRotationRadianPerLoop, sender: sender)
    }
    
}

