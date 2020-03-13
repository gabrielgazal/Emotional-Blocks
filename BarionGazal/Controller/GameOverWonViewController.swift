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
    
    @IBOutlet weak var menu: NSLayoutConstraint!
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
    
    @IBOutlet weak var colorView: EditableView!
    var viewController: GameViewController!
    override func viewDidLoad() {
        super.viewDidLoad()
        if Model.instance.ganhouFase{
            if Model.instance.faseSelecionada + 1 != Model.instance.numeroFasesTotal{
                MainLabel.text = "WELL DONE!"
                MainLabel.textColor = #colorLiteral(red: 0.4941176471, green: 0.9019607843, blue: 0.5215686275, alpha: 1)
                menuButton.setBackgroundImage(UIImage(named: "backMenu"), for: .normal)
                nextResetButton.setBackgroundImage(UIImage(named: "NextArrowButton"), for: .normal)
            }else{
                MainLabel.text = "END OF THE GAME"
                menuButton.setBackgroundImage(UIImage(named: "backMenu"), for: .normal)
                nextResetButton.isHidden = true
                MainLabel.textColor = #colorLiteral(red: 0.6085866094, green: 0.7251073122, blue: 1, alpha: 1)

                
                menu.constant = 35
            }
        }else{
            MainLabel.text = "TRY AGAIN"
            MainLabel.textColor = #colorLiteral(red: 0.9607843137, green: 0.5294117647, blue: 0.5294117647, alpha: 1)
            menuButton.setBackgroundImage(UIImage(named: "backMenu"), for: .normal)
            nextResetButton.setBackgroundImage(UIImage(named: "reset"), for: .normal)
        }
    }
    


}
