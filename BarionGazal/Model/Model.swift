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
    var fases: [Bool] = [false,false,false,false,false,false,false,false,false,false,false,false,false,false,false]
    static var instance = Model()
    var numeroFasesTotal = 15
    var ganhouFase = false
    var perdeuFase = false
    var somLigado = true
    
    private init(){
        
    }
}

