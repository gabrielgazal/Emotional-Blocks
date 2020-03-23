//
//  GameScene.swift
//  BarionGazal
//
//  Created by Gabriel Gazal on 03/03/20.
//  Copyright © 2020 Gabriel Gazal. All rights reserved.
//

import SpriteKit
import GameplayKit
import Firebase

class GameScene: SKScene {
    
    var player: SKNode!
    var verdes: [SKNode?] = []
    var inimigos = 0
    var incremento = 1

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
        
        
        for child in children {
            if let field = child.childNode(withName: "campinho") as? SKFieldNode {
                
                field.direction = .init(-9.6, 0, 0)
            } else if let field = child.childNode(withName: "edadivarg") as? SKFieldNode {
                field.direction = .init(0, 9.6, 0)
                
            } else if let field = child.childNode(withName: "ohnipmac") as? SKFieldNode {
                field.direction = .init(9.6, 0, 0)
                
            }
        }
    }
    
    
    func touchDown(atPoint pos : CGPoint) {
        
        let generator = UINotificationFeedbackGenerator()
        let medGen = UIImpactFeedbackGenerator(style: .medium)
        let lightGen = UIImpactFeedbackGenerator(style: .light)
        let heavyGen = UIImpactFeedbackGenerator(style: .heavy)
        
        let node = atPoint(pos)
        if node.name == "red" {
            generator.notificationOccurred(.success)
            node.removeFromParent()
            inimigos -= 1
            Model.instance.toquesFase[Model.instance.faseSelecionada] += 1
            AudioManager.shared.play(soundEffect: .pop)
            
            
        }else if node.name == "blue"{
            node.removeFromParent()
            AudioManager.shared.play(soundEffect: .pop)
            generator.notificationOccurred(.success)
            Model.instance.toquesFase[Model.instance.faseSelecionada] += 1
            
        } else if node.name == "green" || node.name == "orange" || node.name == "bloco"{
            //            generator.notificationOccurred(.warning)
            heavyGen.impactOccurred()
            
        }
        
    }
    
    
    
    func verificaVerde(jog: SKNode) -> Bool{
        
        var res = false
        
        if (abs(jog.physicsBody!.velocity.dx) < 0.0001 && abs(jog.physicsBody!.velocity.dy) < 0.0001) && jog.physicsBody!.angularVelocity < 0.0001{
            res = true
        }else{
            res = false
        }
        return res
    }
    
    
    func verificaGreens() -> Bool{
        if inimigos == 0{
            var resVerde = true
            var total = verdes.count
                   
                   for green in verdes{
                       if !verificaVerde(jog: green!){
                           resVerde = false
                        total -= 1
                       }
                   }
            return resVerde
            
        }else{
            return false
        }
        
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
        let verdeTela = verdesNaTela()
        verificaVermelhos()
//        print(incremento)
        if incremento % 31 == 0{
            incremento = 1
            print("testou")
            
            if inimigos == 0 {
                let resultadoVerde = verificaGreens()

                if resultadoVerde {
                    
                    Model.instance.ganhouFase = true
                    Model.instance.fases[Model.instance.faseSelecionada] = true
                    Model.instance.fasesPossiveis[Model.instance.faseSelecionada + 1] = true
                    UserDefaults.standard.set(Model.instance.fasesPossiveis, forKey: "fasesPossiveis")
                    UserDefaults.standard.set(Model.instance.fases, forKey: "fases")
                    
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute: {
                        self.isPaused = true
                        self.viewController.gameOverWon()
                        
                    })
                    
                }
            }
            
            if !verdeTela{
                //            print("perdeu")
                Model.instance.perdeuFase = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3 , execute: {
                    self.isPaused = true
                    
                    self.viewController.gameOverWon()
                    
                })
                
                
            }
        }else{
            incremento += 1
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
