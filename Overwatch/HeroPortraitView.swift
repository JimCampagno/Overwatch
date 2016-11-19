//
//  HeroPortraitView.swift
//  Overwatch
//
//  Created by Jim Campagno on 10/29/16.
//  Copyright © 2016 Gamesmith, LLC. All rights reserved.
//

import UIKit
import SceneKit

class HeroPortraitView: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var portraitImageView: UIImageView!
    
    var hero: Hero! {
        didSet {
            portraitImageView.image = hero.portrait
        }
    }
    
    var offset: CGPoint! {
        didSet {
            
            //TODO:
            
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("HeroPortraitView", owner: self, options: nil)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(contentView)
        contentView.constrainEdges(to: self)
        createStarParticles()
        backgroundColor = UIColor.clear
        contentView.backgroundColor = UIColor.clear
        
        // portraitImageView.layer.borderWidth = 0.5
        // portraitImageView.layer.borderColor = UIColor(red:0.09, green:0.55, blue:0.74, alpha:1.00).cgColor
        
    }
    
    private func createStarParticles() {
        let smokeView = SCNView()
        smokeView.scene = SCNScene()
        smokeView.backgroundColor = UIColor.clear
        smokeView.translatesAutoresizingMaskIntoConstraints = false
        portraitImageView.insertSubview(smokeView, at: 0)
        smokeView.constrainEdges(to: portraitImageView, padding: Padding(top: -100, bottom: -200, leading: 0, trailing: 0))
        let smoke = SCNParticleSystem(named: "StarStuff", inDirectory: nil)!
        smokeView.scene?.rootNode.addParticleSystem(smoke)
    }
    
}
