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
        }
    }
    
    var type: String {
        switch name {
        case .genji, .mcCree, .pharah, .reaper, .soldier, .tracer: return "\(Type.offense)"
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
        case .genji:
            return [Affiliation.shimadaClan(formerly: true), Affiliation.overwatch(formerly: true)]
        case .mcCree:
            return [Affiliation.overwatch(formerly: true)]
        case .pharah:
            return [Affiliation.helix]
        case .reaper:
            return [Affiliation.unknown]
        case .soldier:
            return [Affiliation.overwatch(formerly: true)]
        case .tracer:
            return [Affiliation.overwatch(formerly: true)]
        }
    }
    
   
    
}


enum Name: CustomStringConvertible {
    case genji, mcCree, pharah, reaper, soldier, tracer
    
    var description: String {
        switch self {
        case .genji: return "Genji"
        case .mcCree: return "McCree"
        case .pharah: return "Pharah"
        case .reaper: return "Reaper"
        case .soldier: return "Soldier 76"
        case .tracer: return "Tracer"
        }
    }
    
    var realName: String {
        switch self {
        case .genji: return "Genji Shimada"
        case .mcCree: return "Jesse McCree"
        case .pharah: return "Fareeha Amari"
        case .reaper: return "Unknown"
        case .soldier: return "Unknown"
        case .tracer: return "Lena Oxton"
        }
    }
    
}

enum Type: CustomStringConvertible {
    case offense, defense, tank, support
    
    var description: String {
        switch self {
        case .offense: return "Offense"
        case .defense: return "Defense"
        case .tank: return "Tank"
        case .support: return "Support"
        }
    }
}

enum Occupation: CustomStringConvertible {
    case adventurer, bountyHunter, securityChief, mercenary, vigilante
    
    var description: String {
        switch self {
        case .adventurer: return "Adventurer"
        case .bountyHunter: return "Bounty Hunter"
        case .securityChief: return "Security Chief"
        case .mercenary: return "Mercenary"
        case .vigilante: return "Vigilante"
        }
    }
}


enum BaseOfOperations: CustomStringConvertible {
    case shambali, santaFe, giza, unknown, london
    
    var description: String {
        switch self {
        case .shambali: return "Shambali Monastery, Nepal"
        case .santaFe: return "Santa Fe, New Mexico, USA"
        case .giza: return "Giza, Egypt"
        case .unknown: return "Unknown"
        case .london: return "London, England"
        }
    }
    
}


enum Affiliation: CustomStringConvertible {
    case shimadaClan(formerly: Bool)
    case overwatch(formerly: Bool)
    case helix
    case unknown
    
    var description: String {
        switch self {
        case let .shimadaClan(response):
            return "Shimada Clan " + isFormerly(response)
        case let .overwatch(response):
            return "Overwatch " + isFormerly(response)
        case .helix:
            return "Helix Security International"
        case .unknown:
            return "Unknown"
        }
    }
    
    func isFormerly(_ response: Bool) -> String {
        return response ? "(formerly)" : ""
    }
    
}
