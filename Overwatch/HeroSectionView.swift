//
//  HeroSectionView.swift
//  Overwatch
//
//  Created by Jim Campagno on 10/22/16.
//  Copyright © 2016 Gamesmith, LLC. All rights reserved.
//

import UIKit

class HeroSectionView: UIView {
    
    static let height = 45
    static let width = 375

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var symbolImageView: UIImageView!
    var images: [UIImage] = []
    var index: Int = 0
    
    var type: Type! {
        didSet {
            let displayText = "\(type!)"
            typeLabel.text = displayText.uppercased()
        }
    }
    
    init() {
        super.init(frame: CGRect(x: 0, y: 0, width: HeroSectionView.width, height: HeroSectionView.height))
        commonInit()
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
        Bundle.main.loadNibNamed("HeroSectionView", owner: self, options: nil)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(contentView)
        contentView.constrainEdges(to: self)
        produceImages()
        repeatingAnimation()
    }
    
    private func produceImages() {
        for i in (0...14) {
            let number = i != 0 ? String(i) : ""
            let image = UIImage(named: "SymbolOrange" + number)!
            if i == 14 { images.append(contentsOf: [image, image, image, image, image, image, image, image]) }
            images.append(image)
        }
        index = images.count
    }
    
    func repeatingAnimation() {
        index -= 1
        if index < 0 { index = images.count - 1 }
        let image = images[index]
        
        UIView.transition(with: symbolImageView, duration: 0.3, options: .transitionCrossDissolve, animations: {
            self.symbolImageView.image = image
            }) { success in
                self.repeatingAnimation()
        }
    
    }
    
   

}

extension UIColor {
    static var randomColor: UIColor {
        let colors: [UIColor] = [.red, .yellow, .blue, .green, .gray, .orange]
        let randomIndex = Int(arc4random_uniform(UInt32(colors.count)))
        return colors[randomIndex]
    }
}
