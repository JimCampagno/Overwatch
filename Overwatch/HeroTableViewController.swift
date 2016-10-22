//
//  HeroTableViewController.swift
//  Overwatch
//
//  Created by Jim Campagno on 10/22/16.
//  Copyright © 2016 Gamesmith, LLC. All rights reserved.
//

import UIKit

class HeroTableViewController: UITableViewController {
    
    var heroes: [Hero]!
    var types: [Type]!

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
        let height = 20
        let sectionView = UIView(frame: CGRect(x: 0, y: 0, width: width, height: height))
        sectionView.backgroundColor = UIColor(red:0.09, green:0.09, blue:0.09, alpha:0.9)
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        sectionView.addSubview(label)
        label.constrainEdges(to: sectionView, padding: Padding(top: 8, bottom: 8, leading: 8, trailing: 0))
        
        label.text = "\(types[section])"
        
        return sectionView
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    

}

extension UIColor {
    static var lightBlack: UIColor {
        return UIColor(red:0.08, green:0.08, blue:0.08, alpha:1.00)
    }
}
