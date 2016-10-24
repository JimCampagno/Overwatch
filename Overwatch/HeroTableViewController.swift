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
    
    var heroes: [Type : [Hero]]!
    var audioPlayer: AVAudioPlayer!
    var sectionViews: [HeroSectionView]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        addGestureRecognizer(to: tableView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        createSectionViews()
    }
    
}

// MARK: - UITableView Methods
extension HeroTableViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return heroes.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sortedTypes = Array(heroes.keys).sorted { $0 < $1 }
        let type = sortedTypes[section]
        let heroesForType = heroes[type]!
        return heroesForType.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HeroCell", for: indexPath) as! HeroTableViewCell
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let heroCell = cell as! HeroTableViewCell
        let sortedTypes = Array(heroes.keys).sorted { $0 < $1 }
        let type = sortedTypes[indexPath.section]
        let heroesForType = heroes[type]!
        heroCell.hero = heroesForType[indexPath.row]
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let heroSectionView = sectionViews[section]
        heroSectionView.willDisplay()
        return heroSectionView
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat(HeroSectionView.height)
    }
    
}


// MARK: - Setup Methods
extension HeroTableViewController {
    
    func setup() {
        setupAudioPlayer()
        setupBarButtonItem()
        heroes = [.offense : Hero.offense, .defense : Hero.offense]
        view.backgroundColor = UIColor.lightBlack
    }
    
    func setupAudioPlayer() {
        let filePath = Bundle.main.path(forResource: "GunShot", ofType: "wav")!
        let url = URL(fileURLWithPath: filePath)
        audioPlayer = try! AVAudioPlayer(contentsOf: url)
    }
    
    func setupBarButtonItem() {
        let mcCreeWeapon = McCreeWeaponView(frame: CGRect(x: 0, y: 0, width: 70, height: 35))
        let barButtonItem = UIBarButtonItem(customView: mcCreeWeapon)
        navigationItem.rightBarButtonItem = barButtonItem
    }
    
    func addGestureRecognizer(to view: UIView) {
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
        view.addGestureRecognizer(gestureRecognizer)
    }
    
}

// MARK: - Section Header Views
extension HeroTableViewController {
    
    func createSectionViews() {
        let width = Int(tableView.frame.size.width)
        let height = HeroSectionView.height
        let frame = CGRect(x: 0, y: 0, width: width, height: height)
        
        let offense = HeroSectionView(frame: frame, type: .offense)
        let defense = HeroSectionView(frame: frame, type: .defense)
        let tank = HeroSectionView(frame: frame, type: .tank)
        let support = HeroSectionView(frame: frame, type: .support)
        
        sectionViews = [offense, defense, tank, support]
    }
    
}

// MARK: - Action Methods
extension HeroTableViewController {
    
    func viewTapped(_ sender: UITapGestureRecognizer) {
        // TODO: Does AVAudioPlayer have a delegate that will let us know when the sound file is done playing?
        // TODO: If so, then we have a flag in the provided method that gets switched on.
        // TODO: That switch is checked here in this method when it's called. If a certain condition, then we create a nother AVPlayer to play the identical sound.
        // TODO: ---- WHY? AVAudioPlayer doesn't allow you to play multiple sounds (or even queue them up) on this same AVAudioPlayer instance.
        // TODO: -----WHY? A person will need to tap the screen multiple times (faster than when the sound files stop playing).
        // TODO: -----WHY? We want then for every tap (shot) for this gunshot sound to play
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
        
        UIView.animateRainbow(in: tableView, center: point) { success in
            DispatchQueue.main.async {
                print("We super complete.")
            }
        }
    }
    
    
}




