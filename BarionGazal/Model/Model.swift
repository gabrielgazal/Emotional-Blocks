//
//  Model.swift
//  BarionGazal
//
//  Created by Gabriel Gazal on 04/03/20.
//  Copyright © 2020 Gabriel Gazal. All rights reserved.
//

import Foundation
import SpriteKit

class Model{
    
    var faseSelecionada = 0
    var fases: [SKScene]!
    static var instance = Model()

    private init(){
        self.fases = [
            SKScene(fileNamed: "Level1")!,
            SKScene(fileNamed: "Level2")!
        ]
    }
}

