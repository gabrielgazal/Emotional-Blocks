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
    static let instance = Model()

    var faseSelecionada = 0
    var fases: [Bool] = []
    var fasesPossiveis: [Bool] = [true]
    var toquesFase: [Int] = []
    var numeroFasesTotal = 25
    
    
    var ganhouFase = false
    var perdeuFase = false
    var somLigado = true
    
    
    private init(){
        
    }
}

