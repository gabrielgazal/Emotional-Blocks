//
//  MenuViewController.swift
//  BarionGazal
//
//  Created by Gabriel Gazal on 04/03/20.
//  Copyright © 2020 Gabriel Gazal. All rights reserved.
//

import UIKit
import SpriteKit


class MenuViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    @IBOutlet weak var homeButton: UIButton!
    @IBAction func backhome(_ sender: Any) {
        navigationController?.popToRootViewController(animated: true)
        AudioManager.shared.play(soundEffect: .button)
        
    }
    
    var spacing:CGFloat = 5.0
    var nCelulas = 10.0
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Model.instance.numeroFasesTotal
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: "faseCell", for: indexPath) as! FaseCollectionViewCell
        cell.numeroLabel.text = "\(indexPath.row + 1)"
        
        if Model.instance.fases[indexPath.row]{
            cell.colorView.backgroundColor = #colorLiteral(red: 0.8901960784, green: 0.8941176471, blue: 1, alpha: 1)
            
            
        }else if Model.instance.fasesPossiveis[indexPath.row]{
            cell.colorView.backgroundColor = #colorLiteral(red: 0.968627451, green: 0.9333333333, blue: 0.9333333333, alpha: 1)
        }else{
            cell.colorView.backgroundColor = #colorLiteral(red: 0.862745098, green: 0.862745098, blue: 0.862745098, alpha: 1)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return spacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .zero
    }
    
    //       func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    //        let width = (self.collection.frame.width / 10.0) - 10.0
    //
    ////           return CGSize(width: width, height: width)
    //        return CGSize(width: 150, height: 150)
    //       }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let modelo = Model.instance
        
        if modelo.fasesPossiveis[indexPath.row]{
            Model.instance.faseSelecionada = indexPath.row
            AudioManager.shared.play(soundEffect: .button)
            performSegue(withIdentifier: "faseSegue", sender: nil)
        }else{
            //            AudioManager.shared.play(soundEffect: .button)
        }
        
    }
    @IBOutlet weak var collection: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collection.delegate = self
        self.collection.dataSource = self
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        DispatchQueue.main.async {
            self.collection.reloadData()
        }
    }
    
    
    
}
