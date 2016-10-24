//
//  HeroAttributes.swift
//  Overwatch
//
//  Created by Jim Campagno on 10/23/16.
//  Copyright © 2016 Gamesmith, LLC. All rights reserved.
//

import Foundation


// MARK: - Name
enum Name: CustomStringConvertible {
    case genji, mcCree, pharah, reaper, soldier, tracer
    case bastion, hanzo, junkrat, mei, torbjorn, widowmaker
    
    var description: String {
        switch self {
        case .genji: return "Genji"
        case .mcCree: return "McCree"
        case .pharah: return "Pharah"
        case .reaper: return "Reaper"
        case .soldier: return "Soldier 76"
        case .tracer: return "Tracer"
            
        case .bastion: return "Bastion"
        case .hanzo: return "Hanzo"
        case .junkrat: return "Junkrat"
        case .mei: return "Mei"
        case .torbjorn: return "Torbjörn"
        case .widowmaker: return "Widowmaker"
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
        
        case .bastion: return "SST Laboratories Siege Automaton E54"
        case .hanzo: return "Hanzo Shimada"
        case .junkrat: return "Jamison Fawkes"
        case .mei: return "Mei-Ling Zhou"
        case .torbjorn: return "Torbjörn Lindholm"
        case .widowmaker: return "Amélie Lacroix"
        }
    }
    
}

// MARK: - Type
enum Type: Int, CustomStringConvertible, Hashable, Equatable {
    case offense, defense, tank, support
    
    var description: String {
        switch self {
        case .offense: return "Offense"
        case .defense: return "Defense"
        case .tank: return "Tank"
        case .support: return "Support"
        }
    }
    
    static var allTypes: [Type] {
        return [.offense, .defense, .tank, .support]
    }
    
    var hashValue: Int {
        return "\(self)".hashValue
    }
    
    static func ==(lhs: Type, rhs: Type) -> Bool {
        return lhs.rawValue == rhs.rawValue
    }
    
    static func <(lhs: Type, rhs: Type) -> Bool {
        return lhs.rawValue < rhs.rawValue
    }
}

// MARK: - Occupation
enum Occupation: CustomStringConvertible {
    case adventurer, bountyHunter, securityChief, mercenary, vigilante
    case battleAutomaton, assassin, anarchist, thief, demolitionist, scavenger, climatologist, weaponsDesigner
    
    var description: String {
        switch self {
        case .adventurer: return "Adventurer"
        case .bountyHunter: return "Bounty Hunter"
        case .securityChief: return "Security Chief"
        case .mercenary: return "Mercenary"
        case .vigilante: return "Vigilante"
        
        case .battleAutomaton: return "Battle Automaton"
        case .assassin: return "Assassin"
        case .anarchist: return "Anarchist"
        case .thief: return "Thief"
        case .demolitionist: return "Demolitionist"
        case .scavenger: return "Scavenger"
        case .climatologist: return "Climatologist"
        case .weaponsDesigner: return "Weapons Designer"
        
        }
    }
}


// MARK: - Base of Operations
enum BaseOfOperations: CustomStringConvertible {
    case shambali, santaFe, giza, unknown, london, gothenburg, annecy
    case hanamura(formerly: Bool)
    case junkertown(formerly: Bool)
    case xian(formerly: Bool)
    
    var description: String {
        switch self {
        case .shambali: return "Shambali Monastery, Nepal"
        case .santaFe: return "Santa Fe, New Mexico, USA"
        case .giza: return "Giza, Egypt"
        case .unknown: return "Unknown"
        case .london: return "London, England"
        case let .hanamura(response): return "Hanamura, Japan " + isFormerly(response)
        case let .junkertown(response): return "Junkertown, Australia " + isFormerly(response)
        case let .xian(response): return "Xi’an, China " + isFormerly(response)
        case .gothenburg: return "Gothenburg, Sweden"
        case .annecy: return "Annecy, France"
        }
    }
    
    func isFormerly(_ response: Bool) -> String {
        return response ? "(formerly)" : ""
    }

}


// MARK: - Affiliation
enum Affiliation: CustomStringConvertible {
    case shimadaClan(formerly: Bool)
    case overwatch(formerly: Bool)
    case junkers(formerly: Bool)
    case helix
    case talon
    case unknown
    case none
    
    var description: String {
        switch self {
        case let .shimadaClan(response): return "Shimada Clan " + isFormerly(response)
        case let .overwatch(response): return "Overwatch " + isFormerly(response)
        case let .junkers(response): return "Junkers " + isFormerly(response)
        case .helix: return "Helix Security International"
        case .unknown: return "Unknown"
        case .none: return "None"
        case .talon: return "Talon"
        }
    }
    
    func isFormerly(_ response: Bool) -> String {
        return response ? "(formerly)" : ""
    }
    
}
