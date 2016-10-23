//
//  HeroTableViewCell.swift
//  Overwatch
//
//  Created by Jim Campagno on 10/22/16.
//  Copyright © 2016 Gamesmith, LLC. All rights reserved.
//

import UIKit

class HeroTableViewCell: UITableViewCell {
    
    var heroView: HeroView!
    
    var hero: Hero! {
        didSet {
            heroView.hero = hero
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    private func commonInit() {
        heroView = HeroView()
        heroView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(heroView)
        heroView.constrainEdges(to: contentView)
    }
    
    
    

    
}
