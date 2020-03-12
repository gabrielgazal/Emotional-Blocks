//
//  StartViewController.swift
//  BarionGazal
//
//  Created by Gabriel Gazal on 12/03/20.
//  Copyright © 2020 Gabriel Gazal. All rights reserved.
//

import UIKit

class StartViewController: UIViewController {
    @IBAction func startGame(_ sender: Any) {
        AudioManager.shared.play(soundEffect: .button)

    }
    
    @IBAction func openSEttings(_ sender: Any) {
        AudioManager.shared.play(soundEffect: .button)

    }
    
    @IBAction func openStore(_ sender: Any) {
        AudioManager.shared.play(soundEffect: .button)

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
