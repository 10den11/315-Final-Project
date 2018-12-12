//
//  RollViewController.swift
//  Arcana
//
//  Created by Reid, Jon Carl on 12/11/18.
//  Copyright © 2018 Reid, Jon Carl. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class RollSceneController: UIViewController {

    
    @IBOutlet var dieSKView: SKView!
    
    @IBOutlet var modifierLabel: UILabel!
    
    var die = SKSpriteNode()
    var scene = SKScene()
    
    var timer: Timer? = nil
    let dieRollingImageNameArray: [SKTexture] = [SKTexture(imageNamed: "rolling_1"), SKTexture(imageNamed: "rolling_2"), SKTexture(imageNamed: "rolling_3"), SKTexture(imageNamed: "rolling_4"), SKTexture(imageNamed: "rolling_5")]
    let dieFaceImageNameArray: [SKTexture] = [SKTexture(imageNamed: "side_1"), SKTexture(imageNamed: "side_2"), SKTexture(imageNamed: "side_3"), SKTexture(imageNamed: "side_4"), SKTexture(imageNamed: "side_5"), SKTexture(imageNamed: "side_6"), SKTexture(imageNamed: "side_7"), SKTexture(imageNamed: "side_8"), SKTexture(imageNamed: "side_9"), SKTexture(imageNamed: "side_10"), SKTexture(imageNamed: "side_11"), SKTexture(imageNamed: "side_12"), SKTexture(imageNamed: "side_13"), SKTexture(imageNamed: "side_14"), SKTexture(imageNamed: "side_15"), SKTexture(imageNamed: "side_16"), SKTexture(imageNamed: "side_17"), SKTexture(imageNamed: "side_18"), SKTexture(imageNamed: "side_19"), SKTexture(imageNamed: "side_20")]
    
    @IBAction func rollDieButtonPressed(_ sender: UIButton) {
        print("roll Die Button Pressed")
        animateDie()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scene.scaleMode = .aspectFill
        dieSKView.presentScene(scene)
        die = SKSpriteNode(imageNamed: "side_1")
        die.size = CGSize(width: 0.5, height:0.5)
        die.position = CGPoint(x: scene.frame.midX, y: scene.frame.midY + 0.1)
        scene.addChild(die)

        // Do any additional setup after loading the view.
    }
    
        
    func animateDie(){
        
        let twoNewTexture = SKAction.animate(with: dieRollingImageNameArray, timePerFrame: 0.1, resize: false, restore: false)
        let repeatAction = SKAction.repeat(twoNewTexture, count: 6)
        //die.run(repeatAction)
        let randomFaceIndex = Int.random(in: 0...19)
        let chooseRandomFace = SKAction.setTexture(dieFaceImageNameArray[randomFaceIndex])
        //die.run(chooseRandomFace)
        let animationSequence = SKAction.sequence([repeatAction, chooseRandomFace])
        die.run(animationSequence)
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
