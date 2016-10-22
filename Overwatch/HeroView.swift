//
//  HeroView.swift
//  Overwatch
//
//  Created by Jim Campagno on 10/22/16.
//  Copyright © 2016 Gamesmith, LLC. All rights reserved.
//

import UIKit

class HeroView: UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var heroImageView: UIImageView!
    @IBOutlet weak var heroNameLabel: UILabel!
    @IBOutlet weak var occupationLabel: UILabel!
    @IBOutlet weak var realNameAgeLabel: UILabel!
    @IBOutlet weak var baseOfOperationsLabel: UILabel!
    @IBOutlet weak var firstAffiliationLabel: UILabel!
    @IBOutlet weak var secondAffiliationLabel: UILabel!
    
    var hero: Hero! {
        didSet {
            setupViews(with: hero)
        }
    }
    
    var affiliationLabels: [UILabel]!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    init() {
        super.init(frame: CGRect(x: 0, y: 0, width: 375, height: 200))
        commonInit()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("HeroView", owner: self, options: nil)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(contentView)
        contentView.constrainEdges(to: self)
        affiliationLabels = [firstAffiliationLabel, secondAffiliationLabel]
    }
    
    private func setupViews(with hero: Hero) {
        heroImageView.image = hero.image
        heroNameLabel.text = hero.nickName
        realNameAgeLabel.text = hero.realNameAndAge
        occupationLabel.text = hero.occupation
        baseOfOperationsLabel.text = hero.baseOfOperations
        
        let affiliations = hero.affiliations
        determineLabelsToDisplay(with: affiliations.count)
        
        for (index, affiliation) in affiliations.enumerated() {
            affiliationLabels[index].text = "\(affiliation)"
        }
    }
    
    private func determineLabelsToDisplay(with count: Int) {
        if count < 2 {
            secondAffiliationLabel.isHidden = true
        } else {
            if secondAffiliationLabel.isHidden { secondAffiliationLabel.isHidden = false }
        }
    }
    
}


extension UIView {
    func constrainEdges(to view: UIView) {
        leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}
