//
//  HeroSectionView.swift
//  Overwatch
//
//  Created by Jim Campagno on 10/22/16.
//  Copyright © 2016 Gamesmith, LLC. All rights reserved.
//

import UIKit

class HeroSectionView: UIView {
    
    static let height = 50
    static let width = 375
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var symbolImageView: UIImageView!
    var images: [UIImage] = []
    var index: Int = 0
    var stopAnimations: Bool = false
    
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
    
    init(frame: CGRect, type: Type) {
        super.init(frame: frame)
        commonInit()
        self.type = type
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
        contentView.backgroundColor = UIColor.lightBlack
        produceImages()
    }
    
}

//: MARK - Animation Methods
extension HeroSectionView {
    
    fileprivate func produceImages() {
        for i in (0...14) {
            let numberString = i != 0 ? String(i) : ""
            let image = UIImage(named: "SymbolOrange" + numberString)!
            if i == 14 { images.append(contentsOf: [image, image, image, image, image, image, image, image]) }
            images.append(image)
        }
        
        index = images.count
    }
    
    func animateSymbol() {
        let image = nextImage()
        
        UIView.transition(with: symbolImageView, duration: 0.1, options: .transitionCrossDissolve, animations: {
            self.symbolImageView.image = image
        }) { [unowned self] _ in
            self.checkForAnimationEnd()
        }
    }
    
    private func nextImage() -> UIImage {
        index -= 1
        let nextImage = image(at: index)
        return nextImage
    }
    
    private func image(at index: Int) -> UIImage {
        if index < 0 { self.index = images.count - 1; stopAnimations = true }
        return images[self.index]
    }
    
    private func checkForAnimationEnd(with success: Bool = true) {
        let shouldKeepOnAnimating = !stopAnimations
        
        guard shouldKeepOnAnimating else { animationCleanup() ; return }
        
        animateSymbol()
    }
    
    private func animationCleanup() {
        symbolImageView.image = images.last!
    }
    
}


//: MARK - Display Methods
extension HeroSectionView {
    
    func willDisplay() {
        stopAnimations = false
        index = 14
        animateSymbol()
    }
    
}

extension UIColor {
    static var randomColor: UIColor {
        let colors: [UIColor] = [.red, .yellow, .blue, .green, .gray, .orange]
        let randomIndex = Int(arc4random_uniform(UInt32(colors.count)))
        return colors[randomIndex]
    }
}
