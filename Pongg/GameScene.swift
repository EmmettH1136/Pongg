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
	var canPlay = false
	var label = SKLabelNode()
	var counter = 0
	
	
    override func didMove(to view: SKView) {
		if canPlay {
		
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
			
			ballPhys!.velocity.dy = CGFloat(Int.random(in: 200...350))
			if xN == 0 {
				ballPhys!.velocity.dx = CGFloat(Int.random(in: -350 ... -200))
			} else {
				ballPhys!.velocity.dx = CGFloat(Int.random(in: 200...350))
			}
			
			ball.physicsBody?.categoryBitMask = ballC
			topPaddle.physicsBody?.categoryBitMask = paddleC
			top.physicsBody?.categoryBitMask = topC
			
			ball.physicsBody?.contactTestBitMask = topC|paddleC
		
			label = SKLabelNode(text: "0")
			label.fontSize = 100.0
			label.position = CGPoint(x: 0, y: -35)
			self.addChild(label)
		}
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
		
		if contact.bodyA.categoryBitMask == topC {
			changePaddle(node: topPaddle)
		}
		if contact.bodyA.categoryBitMask == paddleC {
			counter += 1
			label.text = "\(counter)"
		}
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
	
	func changePaddle(node: SKSpriteNode) {
		if node.color == .yellow {
			node.removeAllActions()
			node.removeFromParent()
		}
		node.color = .yellow
	}
	override func update(_ currentTime: TimeInterval) {
		guard canPlay == false else { return }
		self.run(SKAction.sequence([
			SKAction.run { [weak self] in self?.canPlay = true },
			SKAction.wait(forDuration: 1.0),
			SKAction.run { self.didMove(to: self.view!) }]))

	}
}
