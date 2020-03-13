//
//  GameOverWonViewController.swift
//  BarionGazal
//
//  Created by Gabriel Gazal on 12/03/20.
//  Copyright © 2020 Gabriel Gazal. All rights reserved.
//

import UIKit

class GameOverWonViewController: UIViewController {

    @IBOutlet weak var MainLabel: UILabel!
    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet weak var nextResetButton: UIButton!
    
    @IBAction func backMenu(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        viewController.vaiProMenu()
    }
    @IBAction func restartNext(_ sender: Any) {
        if Model.instance.ganhouFase{
            if Model.instance.faseSelecionada != Model.instance.numeroFasesTotal{
                self.dismiss(animated: true, completion: nil)
                Model.instance.faseSelecionada += 1
                viewController.carregaCena()
            }else{
                self.dismiss(animated: true, completion: nil)
                viewController.vaiProMenu()
            }
        }else{
            self.dismiss(animated: true, completion: nil)
            viewController.carregaCena()
        }
    }
    
    var viewController: GameViewController!
    override func viewDidLoad() {
        super.viewDidLoad()
        if Model.instance.ganhouFase{
            if Model.instance.faseSelecionada + 1 != Model.instance.numeroFasesTotal{
                MainLabel.text = "ganhou!"
                menuButton.setBackgroundImage(UIImage(named: "backMenu"), for: .normal)
                nextResetButton.setBackgroundImage(UIImage(named: "NextArrowButton"), for: .normal)
            }else{
                MainLabel.text = "ACABO TUDO"
                menuButton.setBackgroundImage(UIImage(named: "backMenu"), for: .normal)
                nextResetButton.isHidden = true
                menuButton.layer.position.x = self.view.frame.width/2
            }
        }else{
            MainLabel.text = "perdeu :("
            menuButton.setBackgroundImage(UIImage(named: "backMenu"), for: .normal)
            nextResetButton.setBackgroundImage(UIImage(named: "reset"), for: .normal)
        }
    }
    


}
