//
//  OverwatchHero.swift
//  Overwatch
//
//  Created by Jim Campagno on 10/21/16.
//  Copyright © 2016 Gamesmith, LLC. All rights reserved.
//

import Foundation
import UIKit

protocol OverwatchHero {
    var name: Name { get }
    var realName: String { get }
    var age: String { get }
    var occupation: String { get }
    var baseOfOperations: String { get }
    var affiliations: [Affiliation] { get }
    var type: String { get }
    var image: UIImage { get }
    var realNameAndAge: String { get }
    var nickName: String { get }
}

extension OverwatchHero {
    
    var realName: String {
        return name.realName
    }
    
    var baseOfOperations: String {
        switch name {
        case .genji: return "\(BaseOfOperations.shambali)"
        case .mcCree: return "\(BaseOfOperations.santaFe)"
        case .pharah: return "\(BaseOfOperations.giza)"
        case .reaper: return "\(BaseOfOperations.unknown)"
        case .soldier: return "\(BaseOfOperations.unknown)"
        case .tracer: return "\(BaseOfOperations.london)"
            
        case .bastion: return "\(BaseOfOperations.unknown)"
        case .hanzo: return "\(BaseOfOperations.hanamura(formerly: true))"
        case .junkrat: return "\(BaseOfOperations.junkertown(formerly: true))"
        case .mei: return "\(BaseOfOperations.xian(formerly: true))"
        case .torbjorn: return "\(BaseOfOperations.gothenburg)"
        case .widowmaker: return "\(BaseOfOperations.annecy)"
        }
    }
    
    var occupation: String {
        switch name {
        case .genji: return "\(Occupation.adventurer)"
        case .mcCree: return "\(Occupation.bountyHunter)"
        case .pharah: return "\(Occupation.securityChief)"
        case .reaper: return "\(Occupation.mercenary)"
        case .soldier: return "\(Occupation.vigilante)"
        case .tracer: return "\(Occupation.adventurer)"
            
        case .bastion: return "\(Occupation.battleAutomaton)"
        case .hanzo: return "\(Occupation.mercenary), \(Occupation.assassin)"
        case .junkrat: return "\(Occupation.anarchist), \(Occupation.thief), \(Occupation.demolitionist), \(Occupation.mercenary), \(Occupation.scavenger)"
        case .mei: return "\(Occupation.climatologist), \(Occupation.adventurer)"
        case .torbjorn: return "\(Occupation.weaponsDesigner)"
        case .widowmaker: return "\(Occupation.assassin)"

        
        }
    }
    
    var age: String {
        switch name {
        case .genji: return "35"
        case .mcCree: return "37"
        case .pharah: return "32"
        case .reaper: return "Unknown"
        case .soldier: return "Unknown"
        case .tracer: return "26"
            
        case .bastion: return "30"
        case .hanzo: return "38"
        case .junkrat: return "25"
        case .mei: return "31"
        case .torbjorn: return "57"
        case .widowmaker: return "33"

        }
    }
    
    var type: String {
        switch name {
        case .genji, .mcCree, .pharah, .reaper, .soldier, .tracer: return "\(Type.offense)"
        case .bastion, .hanzo, .junkrat, .mei, .torbjorn, .widowmaker: return "\(Type.defense)"
        }
        
        
    }
    
    var image: UIImage {
        switch name {
        case .genji: return #imageLiteral(resourceName: "Genji")
        case .mcCree: return #imageLiteral(resourceName: "McCree")
        case .pharah: return #imageLiteral(resourceName: "Pharah")
        case .reaper: return #imageLiteral(resourceName: "Reaper")
        case .soldier: return #imageLiteral(resourceName: "Soldier")
        case .tracer: return #imageLiteral(resourceName: "Tracer")
            
        case .bastion: return #imageLiteral(resourceName: "Bastion")
        case .hanzo: return #imageLiteral(resourceName: "Hanzo")
        case .junkrat: return #imageLiteral(resourceName: "Junkrat")
        case .mei: return #imageLiteral(resourceName: "Mei")
        case .torbjorn: return #imageLiteral(resourceName: "Torbjorn")
        case .widowmaker: return #imageLiteral(resourceName: "Widowmaker")
        }
        
    }
    
    var realNameAndAge: String {
        return realName + ", " + age
        
    }
    
    var nickName: String {
        return "\(name)"
    }
    
    var affiliations: [Affiliation] {
        switch name {
        case .genji: return [Affiliation.shimadaClan(formerly: true), Affiliation.overwatch(formerly: true)]
        case .mcCree: return [Affiliation.overwatch(formerly: true)]
        case .pharah: return [Affiliation.helix]
        case .reaper: return [Affiliation.unknown]
        case .soldier: return [Affiliation.overwatch(formerly: true)]
        case .tracer: return [Affiliation.overwatch(formerly: true)]
            
        case .bastion: return [Affiliation.none]
        case .hanzo: return [Affiliation.shimadaClan(formerly: false)]
        case .junkrat: return [Affiliation.junkers(formerly: true)]
        case .mei: return [Affiliation.overwatch(formerly: true)]
        case .torbjorn: return [Affiliation.overwatch(formerly: true)]
        case .widowmaker: return [Affiliation.talon]
            
        }
    }
    
   
    
}



