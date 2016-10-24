//
//  Hero.swift
//  Overwatch
//
//  Created by Jim Campagno on 10/21/16.
//  Copyright © 2016 Gamesmith, LLC. All rights reserved.
//

import Foundation

struct Hero: OverwatchHero {
    var name: Name
    
    static var offense: [Hero] {
        let genji = Hero(name: .genji)
        let mcCree = Hero(name: .mcCree)
        let pharah = Hero(name: .pharah)
        let reaper = Hero(name: .reaper)
        let tracer = Hero(name: .tracer)
        let soldier = Hero(name: .soldier)
        return [genji, mcCree, pharah, reaper, tracer, soldier]
    }
}
