//
//  GameScene.swift
//  BarionGazal
//
//  Created by Gabriel Gazal on 03/03/20.
//  Copyright © 2020 Gabriel Gazal. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var player: SKNode!
    var inimigos = 0
 
    
    override func didMove(to view: SKView) {
        self.children.forEach{ node in
            if node.name == "green"{
                player = node
            } else if node.name == "red" || node.name == "orange" {
                inimigos += 1
            }
            
        }
    
    }
    
    
    func touchDown(atPoint pos : CGPoint) {
        
        self.children.forEach{ node in
            if node.contains(pos){
                if node.name == "red" || node.name == "blue"{
                    node.removeFromParent()
                    inimigos -= 1
                    
                }
            }
            
        }
        
    }
    
    
    func verificaVerde() -> Bool{
        var res = false
        //        print(player.physicsBody!.velocity)
        //        print(player.physicsBody!.angularVelocity)
        if (abs(player.physicsBody!.velocity.dx) < 0.001 && abs(player.physicsBody!.velocity.dy) < 0.001) && player.physicsBody!.angularVelocity < 0.001{
                res = true
            
        }
        return res
    }
    func verificaVermelhos(){
        
        self.children.forEach{node in
            if node.name == "red" || node.name == "orange"{
                if (!intersects(node)){
                    node.removeFromParent()
                    inimigos -= 1
                }
            }
        }
        
    }
    
    
    
    override func update(_ currentTime: TimeInterval) {
        let resultadoVerde = verificaVerde()
        print(inimigos)
        verificaVermelhos()
        if resultadoVerde && inimigos == 0{
            print("top")
            Model.instance.ganhouFase = true
        }
        
        if (!intersects(player)){
            print("perdeu")
            Model.instance.perdeuFase = true
        }
        
    }
    
    
    
    func touchMoved(toPoint pos : CGPoint) {
        
    }
    
    func touchUp(atPoint pos : CGPoint) {
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    
    
}
