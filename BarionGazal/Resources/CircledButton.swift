//
//  CircledButton.swift
//  BarionGazal
//
//  Created by Gabriel Gazal on 11/03/20.
//  Copyright © 2020 Gabriel Gazal. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable class CircledButton: UIButton{
    
    @IBInspectable var cornerRadius: CGFloat = 0{
        didSet{
            self.layer.cornerRadius = self.frame.height / 2.0
        }
    }
    
    @IBInspectable var borderWidht: CGFloat = 0{
        didSet{
            layer.borderWidth = borderWidht
        }
    }
    @IBInspectable var borderColor: UIColor = UIColor.clear {
        didSet{
            layer.borderColor = borderColor.cgColor
        }
    }
    
    
    func updateLayerProperties() {
              self.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
              self.layer.shadowOffset = CGSize(width: 0, height: 3)
              self.layer.shadowOpacity = 3.0
              self.layer.shadowRadius = 10.0
              self.layer.masksToBounds = false
          }
}

