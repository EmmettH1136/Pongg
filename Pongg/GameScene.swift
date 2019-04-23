//
//  GameScene.swift
//  Pongg
//
//  Created by Emmett Hasley on 4/16/19.
//  Copyright © 2019 John Heresy High School. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
	
	var topPaddle = SKSpriteNode()
//	var ball = SKSpriteNode()
    
    override func didMove(to view: SKView) {
		physicsWorld.contactDelegate = self
        let border = SKPhysicsBody(edgeLoopFrom: self.frame)
		self.physicsBody = border
		
//		ball = self.childNode(withName: "ball") as! SKSpriteNode
		topPaddle = self.childNode(withName: "topPaddle") as! SKSpriteNode
    }
	
	func didBegin(_ contact: SKPhysicsContact) {
		if contact.bodyB.velocity.dx < 0.0 {
			contact.bodyB.velocity.dx -= 5
		} else {
			contact.bodyB.velocity.dx += 5
		}
		if contact.bodyB.velocity.dy < 0 {
			contact.bodyB.velocity.dy -= 5
		} else {
			contact.bodyB.velocity.dy += 5
		}
		print(contact.bodyB.velocity)
	}
	
	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		let touch = touches.first!
		let location = touch.location(in: self)
		topPaddle.run(SKAction.moveTo(x: location.x, duration: 0.2))
	}
	override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
		let touch = touches.first!
		let location = touch.location(in: self)
		topPaddle.run(SKAction.moveTo(x: location.x, duration: 0.2))
	}
    
}
