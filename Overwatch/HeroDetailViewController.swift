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
    @IBOutlet weak var heroStoryView: HeroStoryView!
    @IBOutlet weak var heroImageView: UIImageView!
    
    var heroView: HeroView!
    var selectedFrame: CGRect!
    var hero: Hero!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        basicSetup()
        performAnimations()
    }
    
    func dismissView() {
        UIView.animate(withDuration: 0.4, animations: {
            self.view.subviews.forEach { $0.alpha = 0.0 }
        }) { _ in
            self.dismiss(animated: false, completion: nil)
        }
        
    }
    
}

// MARK: - Setup
extension HeroDetailViewController {
    
    func basicSetup() {
        topImageView.alpha = 0.0
        heroStoryView.delegate = self
        heroStoryView.hero = hero
        heroStoryView.alpha = 0.0
        heroView = HeroView(frame: selectedFrame)
        heroView.hero = hero
        visualEffectView.addSubview(heroView)
        heroLabel.text = "\(hero.name)"
        heroLabel.alpha = 0.0
        visualEffectView.alpha = 0.0
        heroImageView.image = hero.wideImage
        heroImageView.alpha = 0.0
    }
    
}

// MARK: - Animations
extension HeroDetailViewController {
    
    func performAnimations() {
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissView))
        gestureRecognizer.numberOfTapsRequired = 1
        view.addGestureRecognizer(gestureRecognizer)
        
        UIView.animate(withDuration: 0.3) {
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
        
        UIView.transition(with: heroStoryView, duration: 1.8, options: [.transitionCrossDissolve, .allowUserInteraction], animations: {
            self.heroStoryView.alpha = 1.0
        }) { _ in }
        
    
    }
    
    
}


// MARK: - HeroStoryViewDelegate
extension HeroDetailViewController: HeroStoryViewDelegate {
    
    func heroStoryViewDidScroll(_ heroStoryView: HeroStoryView, value: CGFloat) {
        
        if (0...0.8).contains(value) {
            heroLabel.alpha = value
            topImageView.alpha = value + 0.2
            heroLabel.transform = CGAffineTransform(scaleX: value, y: value)
        }
        
        let y = heroStoryView.heroScrollView.contentOffset.y
        
        if y > 100.0 {
            let height = heroImageView.frame.size.height
            let percentage = y / height
            var calculation = (1 - (1 - percentage) - 0.6)
            if calculation > 0.0 {
                calculation = calculation * 3.0
            }
            heroImageView.alpha = calculation
        }
    }
}
