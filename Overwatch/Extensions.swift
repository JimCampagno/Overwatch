//
//  Extensions.swift
//  Overwatch
//
//  Created by Jim Campagno on 10/23/16.
//  Copyright © 2016 Gamesmith, LLC. All rights reserved.
//

import Foundation
import UIKit


//MARK: - Padding Struct
struct Padding {
    let top: CGFloat
    let bottom: CGFloat
    let leading: CGFloat
    let trailing: CGFloat
}


//MARK: - UIView Extension
extension UIView {
    
    func constrainEdges(to view: UIView) {
        leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    func constrainEdges(to view: UIView, padding: Padding) {
        leftAnchor.constraint(equalTo: view.leftAnchor, constant: padding.leading).isActive = true
        rightAnchor.constraint(equalTo: view.rightAnchor, constant: -padding.trailing).isActive = true
        topAnchor.constraint(equalTo: view.topAnchor, constant: padding.top).isActive = true
        bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -padding.bottom).isActive = true
    }
    
    static func animateRainbow(in view: UIView, center: CGPoint, handler: @escaping (Bool) -> Void) {
        var images: [UIImage] = []
        
        for i in 1...4 {
            let image = UIImage(named: "Circle" + String(i))!
            images.append(image)
        }
        let image = images.removeFirst()
        let width = image.size.width
        let height = image.size.height
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 140, height: 140))
        imageView.frame.size = CGSize(width: width, height: height)
        imageView.image = image
        view.addSubview(imageView)
        imageView.center = center
        imageView.alpha = 0.5
        
        imageView.animate(images: images, duration: 0.08, center: center) { complete in
            print("We are complete.")
            handler(true)
        }
    }
    
}


//MARK: - UIImageView Extension
extension UIImageView {
    func animate(images: [UIImage]?, duration: TimeInterval, center: CGPoint, handler: @escaping (Bool) -> Void) {
        guard var images = images else { handler(true); return }
        
        let currentImage = images.removeFirst()
        let expandingView = UIView(frame: CGRect(x: 0, y: 0, width: currentImage.size.width, height: currentImage.size.height))
        addSubview(expandingView)
        expandingView.layer.borderWidth = 3
        expandingView.layer.borderColor = UIColor(red:0.09, green:0.69, blue:0.98, alpha:1.00).cgColor
        expandingView.layer.cornerRadius = expandingView.frame.size.height / 2
        expandingView.layer.masksToBounds = true
        
        UIView.transition(with: self, duration: duration, options: .transitionCrossDissolve, animations: {
            self.image = currentImage
            self.frame.size = currentImage.size
            self.center = center
            expandingView.transform = CGAffineTransform(scaleX: 5, y: 5)
            expandingView.alpha = 0.0
            self.alpha -= 0.4
        }) { _ in
            self.animate(images: images.isEmpty ? nil : images, duration: duration, center: center, handler: handler)
        }
    }
    
}


//MARK: - UIColor Extension
extension UIColor {
    static var lightBlack: UIColor {
        return UIColor(red:0.08, green:0.08, blue:0.08, alpha:1.00)
    }
}
