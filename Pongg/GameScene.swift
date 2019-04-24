//
//  GameScene.swift
//  Pongg
//
//  Created by Emmett Hasley on 4/16/19.
//  Copyright © 2019 John Heresy High School. All rights reserved.
//

import SpriteKit
import GameplayKit

let ballC : UInt32 = 1
let topC : UInt32 = 2
let paddleC : UInt32 = 4 // 0 x 1 << 5

class GameScene: SKScene, SKPhysicsContactDelegate {
	
	var topPaddle = SKSpriteNode()
	var ball = SKSpriteNode()
	let xN = Int.random(in: 0...1)
	
	
    override func didMove(to view: SKView) {
		physicsWorld.contactDelegate = self
        let border = SKPhysicsBody(edgeLoopFrom: self.frame)
		self.physicsBody = border
		
		let topLeft = CGPoint(x: frame.origin.x, y: -frame.origin.y)
		let topRight = CGPoint(x: -frame.origin.x, y: -frame.origin.y)
		
		let top = SKNode()
		top.name = "top"
		top.physicsBody = SKPhysicsBody(edgeFrom: topLeft, to: topRight)
		self.addChild(top)
		
		ball = self.childNode(withName: "grapfrut") as! SKSpriteNode
		topPaddle = self.childNode(withName: "topPaddle") as! SKSpriteNode
		let ballPhys = ball.physicsBody
		
		ballPhys!.velocity.dy = CGFloat(Int.random(in: 100...250))
		if xN == 0 {
			ballPhys!.velocity.dx = CGFloat(Int.random(in: -250 ... -100))
		} else {
			ballPhys!.velocity.dx = CGFloat(Int.random(in: 100...250))
		}
		
		ball.physicsBody?.categoryBitMask = ballC
		topPaddle.physicsBody?.categoryBitMask = paddleC
		top.physicsBody?.categoryBitMask = topC
		
		ball.physicsBody?.contactTestBitMask = topC|paddleC
		
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
