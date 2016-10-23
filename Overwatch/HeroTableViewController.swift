//
//  HeroTableViewController.swift
//  Overwatch
//
//  Created by Jim Campagno on 10/22/16.
//  Copyright © 2016 Gamesmith, LLC. All rights reserved.
//

import UIKit
import AVFoundation

class HeroTableViewController: UITableViewController {
    
    var heroes: [Hero]!
    var types: [Type]!
    var audioPlayer: AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let genji = Hero(name: .genji)
        let mcCree = Hero(name: .mcCree)
        let pharah = Hero(name: .pharah)
        let reaper = Hero(name: .reaper)
        let tracer = Hero(name: .tracer)
        let soldier = Hero(name: .soldier)
        
        heroes = [genji, mcCree, pharah, reaper, tracer, soldier]
        types = Type.allTypes
        view.backgroundColor = UIColor.lightBlack
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
        tableView.addGestureRecognizer(gestureRecognizer)
        let filePath = Bundle.main.path(forResource: "GunShot", ofType: "wav")!
        let url = URL(fileURLWithPath: filePath)
        audioPlayer = try! AVAudioPlayer(contentsOf: url)
        
        let mcCreeWeapon = McCreeWeaponView(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
        let barButtonItem = UIBarButtonItem(customView: mcCreeWeapon)
        navigationItem.rightBarButtonItem = barButtonItem
    }
    
    func viewTapped(_ sender: UITapGestureRecognizer) {
        audioPlayer.play()
        tableView.isUserInteractionEnabled = false
        let point = sender.location(in: tableView)
        let index = tableView.indexPathForRow(at: point)!
        let cell = self.tableView.cellForRow(at: index) as! HeroTableViewCell
        self.tableView.isUserInteractionEnabled = true
        let viewableCells = self.tableView.visibleCells as! [HeroTableViewCell]
        let nonTappedCells = viewableCells.filter { $0 != cell }
        let rect = self.tableView.rectForRow(at: index)
        let dummyView = cell.heroView.copy(with: rect) as! HeroView
        self.tableView.addSubview(dummyView)
    
        UIView.animate(withDuration: 0.2, animations: {
            nonTappedCells.forEach { $0.heroView.alpha = 0.8 }
            dummyView.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
            dummyView.alpha = 0.0
            
        })

        UIView.animateRainbow(in: tableView, center: point) { [unowned self] success in
            DispatchQueue.main.async {
                print("We super complete.")
            }
        }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return heroes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HeroCell", for: indexPath) as! HeroTableViewCell
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let heroCell = cell as! HeroTableViewCell
        heroCell.hero = heroes[indexPath.row]
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let width = Int(tableView.frame.size.width)
        let height = HeroSectionView.height
        let sectionView = HeroSectionView(frame: CGRect(x: 0, y: 0, width: width, height: height))
        sectionView.type = types[section]
        return sectionView
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat(HeroSectionView.height)
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
    }
    
    
}

extension UIView {
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

extension UIColor {
    static var lightBlack: UIColor {
        return UIColor(red:0.08, green:0.08, blue:0.08, alpha:1.00)
    }
}
