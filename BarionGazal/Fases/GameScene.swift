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
    var verdes: [SKNode?] = []
    var inimigos = 0
    weak var viewController: GameViewController!
    
    
    override func didMove(to view: SKView) {
        
        self.children.forEach{ node in
            node.zPosition = 10
            if node.name == "green"{
                verdes.append(node)
                
            } else if node.name == "red" || node.name == "orange" {
                inimigos += 1
            }
            
        }
        
        let fundo = SKSpriteNode(imageNamed: "background")
        fundo.zPosition = -10
        scene?.addChild(fundo)
        
    }
    
    
    func touchDown(atPoint pos : CGPoint) {
        
        let node = atPoint(pos)
        if node.name == "red" {
            node.removeFromParent()
            inimigos -= 1
            
        }else if node.name == "blue"{
            node.removeFromParent()
            
        }
        print(node.name)
    }
    
    
    func verificaVerde(jog: SKNode) -> Bool{
        
        var res = false
        
        if (abs(jog.physicsBody!.velocity.dx) < 0.001 && abs(jog.physicsBody!.velocity.dy) < 0.001) && jog.physicsBody!.angularVelocity < 0.001{
            res = true
            
        }
        return res
    }
    
    func verificaGreens() -> Bool{
        var res = true
        
        for green in verdes{
            if !verificaVerde(jog: green!){
                res = false
            }
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
    
    func verdesNaTela() -> Bool{
        var res = true
        
        for jogs in verdes{
            if (!intersects(jogs!)){
                res = false
            }
        }
        
        return res
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        
        let resultadoVerde = verificaGreens()
        let verdeTela = verdesNaTela()
        
        print(inimigos)
        verificaVermelhos()
        if resultadoVerde && inimigos == 0{
            print("ganhou")
            Model.instance.ganhouFase = true
            Model.instance.fases[Model.instance.faseSelecionada] = true
            Model.instance.fasesPossiveis[Model.instance.faseSelecionada + 1] = true
            viewController.gameOverWon()
            
        }
        
        if !verdeTela{
            print("perdeu")
            Model.instance.perdeuFase = true
            viewController.gameOverWon()
            
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
