//
//  GameViewController.swift
//  BarionGazal
//
//  Created by Gabriel Gazal on 03/03/20.
//  Copyright © 2020 Gabriel Gazal. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {
    
    @IBOutlet weak var botaoHome: UIButton!
    @IBOutlet weak var botaoReset: UIButton!
    @IBAction func resetScene(_ sender: Any) {
        carregaCena()
        AudioManager.shared.play(soundEffect: .button)
        
    }
    
    @IBAction func goHome(_ sender: Any) {
        vaiProMenu()
    }
    
    func vaiProMenu(){
        
        navigationController?.popToViewController((navigationController?.viewControllers[1])!, animated: true)
        AudioManager.shared.play(soundEffect: .button)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        botaoReset.layer.zPosition = 50
        botaoHome.layer.zPosition = 50
        carregaCena()
        
    }
    
    func carregaCena(){
        
        Model.instance.ganhouFase = false
        Model.instance.perdeuFase = false
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            let scene = SKScene(fileNamed: "Level\(Model.instance.faseSelecionada + 1)") as! GameScene
            // Set the scale mode to scale to fit the window
            scene.scaleMode = .aspectFill
            scene.viewController = self
            // Present the scene
            scene.size = view.bounds.size
            
            
            
            view.presentScene(scene)
            
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
        }
    }
    
    func gameOverWon(){
        performSegue(withIdentifier: "winLoseSegue", sender: nil)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         let proxima =  segue.destination as! GameOverWonViewController
        
        proxima.viewController = self
    }
    
    override var shouldAutorotate: Bool {
        return true
    }
    
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}
