//
//  GameScene.swift
//  gameoflife
//
//  Created by Yonatan Bergman on 6/4/14.
//  Copyright (c) 2014 Yonatan Bergman. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    let pixelSize:CGFloat = 20.0
    var world:World = World()
    
    override func didMoveToView(view: SKView) {
        let node = SKLabelNode(fontNamed: "Helvetica")
        node.fontSize = 30;
        node.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame));
        node.text = "Touch to add cells"
        self.addChild(node)
        
        addExamples()
    }
    
    override func touchesMoved(touches: NSSet, withEvent event: UIEvent) {
        for touch: AnyObject in touches {
            let location = touch.locationInNode(self)
            let point = convertPixelsToPoint(location)
            world.addCell(point)
            self.createCell(point)
        }
    }
   
    var lastUpdateTimeInterval:CFTimeInterval?
    var timeSinceLastTick:Double = -3 // Initial time to setup
    
    override func update(currentTime: CFTimeInterval) {
        if (lastUpdateTimeInterval){
            var timeSinceLast = currentTime - self.lastUpdateTimeInterval!;
            timeSinceLastTick += timeSinceLast
        }
        self.lastUpdateTimeInterval = currentTime;
        
        if (timeSinceLastTick > 0.5) { // seconds per tick
            timeSinceLastTick = 0
            world.tick()
            self.removeAllChildren()
            self.createCells()
        }
    }
    
    func createCells(){
        for cell in world.aliveCells{
            createCell(cell)
        }
    }
    
    func createCell(point: Point) -> SKSpriteNode{
        let sprite = SKSpriteNode()
        sprite.color = UIColor.blackColor()
        sprite.size = CGSizeMake(pixelSize, pixelSize)
        sprite.position = convertPointToPixels(point)
        self.addChild(sprite)
        return sprite
    }
    
    func convertPointToPixels(point:Point) -> CGPoint{
        return CGPointMake(CGFloat(point.x) * pixelSize, CGFloat(point.y) * pixelSize)
    }
    
    func convertPixelsToPoint(pixel: CGPoint) -> Point{
        return Point(x: Int(pixel.x / pixelSize), y: Int(pixel.y / pixelSize))
    }
    
    func addExamples(){
        self.world.addCell(Point(x: 21, y: 21))
        self.world.addCell(Point(x: 22, y: 22))
        self.world.addCell(Point(x: 20, y: 23))
        self.world.addCell(Point(x: 21, y: 23))
        self.world.addCell(Point(x: 22, y: 23))

        self.world.addCell(Point(x: 30, y: 13))
        self.world.addCell(Point(x: 30, y: 14))
        self.world.addCell(Point(x: 30, y: 15))
        
        createCells()
    }
}
