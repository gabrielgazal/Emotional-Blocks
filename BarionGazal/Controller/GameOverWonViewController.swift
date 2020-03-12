//
//  GameOverWonViewController.swift
//  BarionGazal
//
//  Created by Gabriel Gazal on 12/03/20.
//  Copyright © 2020 Gabriel Gazal. All rights reserved.
//

import UIKit

class GameOverWonViewController: UIViewController {

    @IBAction func dismiss(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        viewController.vaiProMenu()
    }
    
    var viewController: GameViewController!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    


}
