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
import Firebase
import GoogleMobileAds

//intersticial ads

extension GameViewController: GADInterstitialDelegate{
    
    func interstitialDidDismissScreen(_ ad: GADInterstitial) {
        self.loadInterAd()
    }
    
    func loadInterAd(){
        let id = "ca-app-pub-6036434756897883/9940097604"
        let testId = "ca-app-pub-3940256099942544/4411468910"
        let ad = GADInterstitial(adUnitID: testId)
        ad.delegate = self
        ad.load(GADRequest())
        self.interAd = ad
    }
    
    func presentInterAd(){
        guard self .interAd.isReady else {return}
        
        self.interAd.present(fromRootViewController: self)
    }
    
}


class GameViewController: UIViewController {
    
    var interAd: GADInterstitial!
    var gamesPlayed: Int = 0
    @IBOutlet weak var botaoHome: UIButton!
    @IBOutlet weak var botaoReset: UIButton!
    @IBAction func resetScene(_ sender: Any) {
        AudioManager.shared.play(soundEffect: .button)
        
        if !botaoReset.isSelected{
            botaoReset.setBackgroundImage(UIImage(named: "reset"), for: .normal)
            botaoHome.isHidden = false
            botaoReset.isSelected = true
            
        }else{
            botaoReset.setBackgroundImage(UIImage(named: "SandButton"), for: .normal)
            carregaCena()
            botaoHome.isHidden = true
            botaoReset.isSelected = false
            
            
        }
        
        //log evento
        Analytics.logEvent("resetou fase", parameters: [
            AnalyticsParameterContentType: "Nova Fase"
        ])
        
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
        loadInterAd()
        
        carregaCena()
        
    }
    
    func carregaCena(){
        //carrega um ad

        if gamesPlayed == 3{
            gamesPlayed = 0
            presentInterAd()
        } else{
            gamesPlayed += 1
        }
        //
        Model.instance.toquesFase[Model.instance.faseSelecionada] = 0
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
            scene.name = "Level\(Model.instance.faseSelecionada + 1)"
            
            
            
            view.presentScene(scene)
            
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = false
            view.showsNodeCount = false
            
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
