//
//  StartViewController.swift
//  BarionGazal
//
//  Created by Gabriel Gazal on 12/03/20.
//  Copyright © 2020 Gabriel Gazal. All rights reserved.
//

import UIKit
import Lottie

class StartViewController: UIViewController {
    @IBAction func startGame(_ sender: Any) {
        AudioManager.shared.play(soundEffect: .button)
        mainAnimation.stop()
        
    }
    
    @IBAction func openSEttings(_ sender: Any) {
        AudioManager.shared.play(soundEffect: .button)
        performSegue(withIdentifier: "settingSegue", sender: nil)
    }
    
    @IBAction func openStore(_ sender: Any) {
        AudioManager.shared.play(soundEffect: .button)
        
    }
    @IBOutlet weak var mainAnimation: AnimationView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //animacao
        startAnimation()
//        
        let defaults = UserDefaults.standard
        if defaults.object(forKey: "fasesPossiveis") == nil{
            
            let max = Model.instance.numeroFasesTotal
            for i in 0...max{
                Model.instance.fasesPossiveis.append(false)
                
            }
            defaults.set(Model.instance.fasesPossiveis, forKey: "fasesPossiveis")
        }else{
            Model.instance.fasesPossiveis = defaults.object(forKey: "fasesPossiveis") as? [Bool] ?? [Bool]()
        }
        
        
        if defaults.object(forKey: "fases") == nil{
            let max = Model.instance.numeroFasesTotal
            for i in 0...max{
                Model.instance.fases.append(false)
            }
            defaults.set(Model.instance.fases, forKey: "fases")
        }else{
            Model.instance.fases = defaults.object(forKey: "fases") as? [Bool] ?? [Bool]()
        }
        
        
    }
    
    func startAnimation(){
        mainAnimation.animation = Animation.named("cenaprincipal")
        mainAnimation.loopMode = .playOnce
        mainAnimation.play()
    }
}
