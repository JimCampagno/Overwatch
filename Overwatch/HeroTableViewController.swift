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
    var heroview: HeroView!
    var selectedFrame: CGRect!
    var selectedHero: Hero!

    
    var topConstraint: NSLayoutConstraint!
    var heightConstraint: NSLayoutConstraint!
    
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
        let type = Type.allTypes[indexPath.section]
        let heroesForType = heroes[type]!
        heroCell.hero = heroesForType[indexPath.row]
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let heroSectionView = sectionViews[section]
        heroSectionView.type = Type.allTypes[section]
        heroSectionView.willDisplay()
        return heroSectionView
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat(HeroSectionView.height)
    }
    
    func retrieveCell(for indexPath: IndexPath, at point: CGPoint) -> HeroTableViewCell {
        let cell = self.tableView.cellForRow(at: indexPath) as! HeroTableViewCell
        return cell
    }
    
    func visibleCells(excluding cell: HeroTableViewCell) -> [HeroTableViewCell] {
        let viewableCells = self.tableView.visibleCells as! [HeroTableViewCell]
        let nonTappedCells = viewableCells.filter { $0 != cell }
        return nonTappedCells
    }
    
}


// MARK: - Setup Methods
extension HeroTableViewController {
    
    func setup() {
        setupAudioPlayer()
        setupBarButtonItem()
        heroes = [.offense : Hero.offense, .defense : Hero.defense]
        view.backgroundColor = UIColor.lightBlack
    }
    
    func setupAudioPlayer() {
        let filePath = Bundle.main.path(forResource: "ElectricSound", ofType: "wav")!
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
        let point = sender.location(in: tableView)
        guard let indexPath = tableView.indexPathForRow(at: point) else { return }
        let cell = retrieveCell(for: indexPath, at: point)
        tableView.isUserInteractionEnabled = false
        
        runAnimations(with: cell, indexPath: indexPath)
        animateSelection(at: point)
        audioPlayer.play()
    }
    
    func animateSelection(at point: CGPoint) {
        UIView.animateRainbow(in: tableView, center: point) { _ in }
    }
    
    func runAnimations(with cell: HeroTableViewCell, indexPath: IndexPath) {
        scale(cell: cell, indexPath: indexPath) { _ in
            self.tableView.isUserInteractionEnabled = true
        }
    }
    
    func scale(cell: HeroTableViewCell, indexPath: IndexPath, handler: @escaping () -> Void) {
        let rect = tableView.rectForRow(at: indexPath)
        let y = abs(self.tableView.contentOffset.y - rect.origin.y)
        let origin = CGPoint(x: 0.0, y: y)
        
        let frame = CGRect(origin: origin, size: rect.size)
        
        heroview = cell.heroView.copy(with: rect) as! HeroView
        selectedHero = heroview.hero
        selectedFrame = frame
        tableView.addSubview(heroview)
    
        delay(0.1) { [unowned self] _ in
            self.performSegue(withIdentifier: "DetailSegue", sender: nil)

        }
        
        UIView.animate(withDuration: 0.3, animations: {
            self.heroview.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self.heroview.alpha = 0.5
            
        }) { [unowned self] _ in
            DispatchQueue.main.async {
                self.tableView.willRemoveSubview(self.heroview)
                self.heroview.removeFromSuperview()

                handler()
            }
        }
        
    }
    
    func delay(_ delay:Double, closure:@escaping ()->()) {
        let when = DispatchTime.now() + delay
        DispatchQueue.main.asyncAfter(deadline: when, execute: closure)
    }

}



// MARK: - Segue Methods
extension HeroTableViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destVC = segue.destination as! HeroDetailViewController
        destVC.selectedFrame = selectedFrame
        destVC.hero = selectedHero
    }
    
}







