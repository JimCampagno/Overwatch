//
//  HeroDetailViewController.swift
//  Overwatch
//
//  Created by Jim Campagno on 10/23/16.
//  Copyright © 2016 Gamesmith, LLC. All rights reserved.
//

import UIKit

class HeroDetailViewController: UIViewController {
    
    @IBOutlet weak var visualEffectView: UIVisualEffectView!
    @IBOutlet weak var topImageView: UIImageView!
    @IBOutlet weak var heroLabel: UILabel!
    
    var heroView: HeroView!
    var selectedFrame: CGRect!
    var hero: Hero!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        topImageView.alpha = 0.0
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        heroView = HeroView(frame: selectedFrame)
        heroView.hero = hero
        visualEffectView.addSubview(heroView)
        heroLabel.text = "\(hero.name)"
        heroLabel.alpha = 0.0
    
        UIView.animate(withDuration: 0.4) {
            self.visualEffectView.alpha = 1.0
        }
        
        UIView.animate(withDuration: 0.8, delay: 0.6, options: .transitionCrossDissolve, animations: {
            self.heroLabel.alpha = 1.0

            
            
        }) { _ in }
        
        UIView.animate(withDuration: 0.9, animations: {
            self.heroView.center.y = (self.selectedFrame.size.height / 2)
            self.heroView.alpha = 0.0
        }) { _ in
        
        }
        
        UIView.transition(with: topImageView, duration: 1.8, options: .transitionCrossDissolve, animations: {
            self.topImageView.alpha = 1.0
        }) { _ in
        
            
        }
        
        
    }

}
