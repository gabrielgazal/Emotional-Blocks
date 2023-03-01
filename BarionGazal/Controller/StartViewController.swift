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
    var primeiravVez = true
    @IBAction func startGame(_ sender: Any) {
        AudioManager.shared.play(soundEffect: .button)
        mainAnimation.stop()
        let lightGen = UIImpactFeedbackGenerator(style: .light)
        lightGen.impactOccurred()
        
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
        if defaults.object(forKey: "fasesPossiveis") == nil {
            
            let max = Model.instance.numeroFasesTotal
            for _ in 0...max{
                Model.instance.fasesPossiveis.append(false)
            }
            defaults.set(Model.instance.fasesPossiveis, forKey: "fasesPossiveis")
        }else{
            Model.instance.fasesPossiveis = defaults.object(forKey: "fasesPossiveis") as? [Bool] ?? [Bool]()
            
            if Model.instance.numeroFasesTotal > Model.instance.fasesPossiveis.count {
                novoDefault()
            }
            
        }
        
        
        if defaults.object(forKey: "fases") == nil {
            let max = Model.instance.numeroFasesTotal
            for _ in 0...max{
                Model.instance.fases.append(false)
            }
            defaults.set(Model.instance.fases, forKey: "fases")
        }else{
            Model.instance.fases = defaults.object(forKey: "fases") as? [Bool] ?? [Bool]()
            if Model.instance.numeroFasesTotal > Model.instance.fases.count{
                novoDefault()
            }
            
        }
        
        if defaults.object(forKey: "toques") == nil {
            let max = Model.instance.numeroFasesTotal
            for _ in 0...max{
                Model.instance.toquesFase.append(0)
            }
            defaults.set(Model.instance.toquesFase, forKey: "toques")
        }else{
            Model.instance.toquesFase = defaults.object(forKey: "toques") as? [Int] ?? [Int]()
            if Model.instance.numeroFasesTotal > Model.instance.toquesFase.count{
                novoDefault()
            }
        }
        
        
    }
    func novoDefault(){
        let defaults = UserDefaults.standard
        
        for _ in Model.instance.fasesPossiveis.count ..< Model.instance.numeroFasesTotal {
            Model.instance.fasesPossiveis.append(false)
            Model.instance.fases.append(false)
            Model.instance.toquesFase.append(0)
        }
        
        defaults.set(Model.instance.fasesPossiveis, forKey: "fasesPossiveis")
        defaults.set(Model.instance.fases, forKey: "fases")
        defaults.set(Model.instance.toquesFase, forKey: "toques")

    }
    
    override func viewDidAppear(_ animated: Bool) {
        startAnimation()
    }
    func startAnimation(){
        
        mainAnimation.animation = Animation.named("cenaprincipal")
        mainAnimation.loopMode = .playOnce
        mainAnimation.play()
        primeiravVez = false
    }
}
