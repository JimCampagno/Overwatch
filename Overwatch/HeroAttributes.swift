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


// MARK: - Base of Operations
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


// MARK: - Affiliation
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
