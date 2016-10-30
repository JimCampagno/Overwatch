//
//  HeroStoryView.swift
//  Overwatch
//
//  Created by Jim Campagno on 10/30/16.
//  Copyright © 2016 Gamesmith, LLC. All rights reserved.
//

import UIKit


protocol HeroStoryViewDelegate: class {
    func heroStoryViewDidScroll(_ heroStoryView: HeroStoryView, value: CGFloat)
}

class HeroStoryView: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var heroPortraitView: HeroPortraitView!
    @IBOutlet weak var storyTextView: UITextView!
    @IBOutlet weak var heroScrollView: UIScrollView!
    weak var delegate: HeroStoryViewDelegate?
    
    var hero: Hero! {
        didSet {
            heroPortraitView.hero = hero
            storyTextView.text = hero.story
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
        Bundle.main.loadNibNamed("HeroStoryView", owner: self, options: nil)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(contentView)
        contentView.constrainEdges(to: self)
        backgroundColor = UIColor.clear
        heroScrollView.delegate = self
        
    }

}

extension HeroStoryView: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let height = heroPortraitView.portraitImageView.frame.size.height
        let offsetX = scrollView.contentOffset.y
        var calculation: CGFloat = -1
        
        if (0...height).contains(offsetX) {
            let percentage = offsetX / height
            let subtraction: CGFloat = 0.2
            calculation = (1.0 - percentage) - subtraction
            heroPortraitView.alpha = calculation
        }
        
        delegate?.heroStoryViewDidScroll(self, value: calculation)

        
    }

}
