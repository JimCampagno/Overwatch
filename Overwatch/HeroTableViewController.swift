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
    
    var topConstraint: NSLayoutConstraint!
    var heightConstraint: NSLayoutConstraint!
    
    var selectionMade = false
    
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
        heroCell.alpha = 1.0
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
        heroes = [.offense : Hero.offense, .defense : Hero.offense]
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
        let indexPath = tableView.indexPathForRow(at: point)!
        let cell = retrieveCell(for: indexPath, at: point)
        selectionMade = true
        tableView.isUserInteractionEnabled = false
        
        audioPlayer.play()
        animateSelection(at: point)
        runAnimations(with: cell, indexPath: indexPath)
    }
    
    func animateSelection(at point: CGPoint) {
        UIView.animateRainbow(in: tableView, center: point) {  [unowned self] _ in
            
        }
        
    }
    
    func runAnimations(with cell: HeroTableViewCell, indexPath: IndexPath) {
        scale(cell: cell, indexPath: indexPath) { [unowned self] _ in
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "DetailSegue", sender: nil)
            }
        }
    }
    
    func scale(cell: HeroTableViewCell, indexPath: IndexPath, handler: @escaping () -> Void) {
        let rect = tableView.rectForRow(at: indexPath)
        let y = abs(self.tableView.contentOffset.y - rect.origin.y)
        let origin = CGPoint(x: 0.0, y: y)
        
        let frame = CGRect(origin: origin, size: rect.size)
        
        heroview = cell.heroView.copy(with: rect) as! HeroView
        tableView.addSubview(heroview)
        
        UIView.animate(withDuration: 0.2, animations: {
            self.heroview.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
            self.heroview.alpha = 0.0
            
        }) { [unowned self] _ in
            DispatchQueue.main.async {
                self.heroview.transform = CGAffineTransform(scaleX: 1, y: 1)
                self.heroview.frame = frame
                handler()
            }
            
        }
        
        
    }
    
    
    
    
    
    
    
    
    //        tableView.addSubview(heroview)
    //
    //        topConstraint = heroview.topAnchor.constraint(equalTo: tableView.topAnchor, constant: rect.origin.y)
    //        topConstraint.isActive = true
    //        let centerXConstraint = heroview.centerXAnchor.constraint(equalTo: tableView.centerXAnchor)
    //        centerXConstraint.isActive = true
    //        heightConstraint = heroview.heightAnchor.constraint(equalToConstant: rect.size.height)
    //        heightConstraint.isActive = true
    //        heroview.widthAnchor.constraint(equalToConstant: rect.size.width).isActive = true
    //
    //        UIView.animate(withDuration: 0.2, animations: {
    //            self.heroview.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
    //            self.heroview.alpha = 0.0
    //
    //        }) { _ in
    //            self.heroview.transform = CGAffineTransform(scaleX: 1, y: 1)
    //            self.animateHeroView(with: cell)
    //        }
    
    
    //    func animateHeroView(with cell: HeroTableViewCell) {
    //
    //        let point = CGPoint(x: 0, y: -tableView.contentInset.top)
    //        self.heroview.alpha = 1.0
    //
    //        UIView.animate(withDuration: 0.2) {
    //
    //        }
    //
    //        UIView.animate(withDuration: 1.5, delay: 0.0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0.8, options: .curveEaseInOut, animations: {
    //            self.heroview.center = CGPoint(x: 414/2, y: ((736 / 2) * 0.5))
    //
    //            // code
    //        }) { _ in
    //
    //
    //            // more code
    //        }
    //
    //
    //        UIView.transition(with: heroview, duration: 2.5, options: .curveEaseInOut, animations: {
    //            // code
    //        }) { _ in
    //            // more code
    //        }
    //
    //    }
    
    
    
}

// MARK: - Segue Methods
extension HeroTableViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destVC = segue.destination as! HeroDetailViewController
        destVC.selectedFrame = heroview.frame
        print("HeroViews frame is \(heroview.frame)")
        destVC.hero = heroview.hero
        print("HeroViews hero is \(heroview.hero)")
    }
    
}







