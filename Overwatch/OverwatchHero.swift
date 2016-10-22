//
//  OverwatchHero.swift
//  Overwatch
//
//  Created by Jim Campagno on 10/21/16.
//  Copyright © 2016 Gamesmith, LLC. All rights reserved.
//

import Foundation

typealias Age = Int

protocol OverwatchHero {
    var name: Name { get }
    var realName: String { get }
    var age: Age { get }
    var occupation: String { get }
    var baseOfOperations: String { get }
    var affiliations: String { get }
}

extension OverwatchHero {
    
    var realName: String {
        return name.realName
    }
    
    var affiliations: String {
        return produceAllAffiliations() ?? "No Affiliations"
    }
    
    
    var baseOfOperations: String {
        switch name {
        case .genji: return "\(BaseOfOperations.shambali)"
        case .mcCree: return "\(BaseOfOperations.santaFe)"
        }
    }
    
    var occupation: String {
        switch name {
        case .genji: return "\(Occupation.adventurer)"
        case .mcCree: return "\(Occupation.bountyHunter)"
        }
    }
    
    var age: Age {
        switch name {
        case .genji: return 35
        case .mcCree: return 37
        }
    }
    
    func allAffiliations() -> [Affiliation] {
        switch name {
        case .genji:
            return [Affiliation.shimadaClan(formerly: true), Affiliation.overwatch(formerly: true)]
        case .mcCree:
            return [Affiliation.overwatch(formerly: true)]
        }
    }
    
    func produceAllAffiliations() -> String? {
        let all = allAffiliations()
        guard !all.isEmpty else { return nil }
        var result = ""
        for (index, affiliation) in all.enumerated() {
            result += "\(affiliation)"
            if index != all.count - 1 {
                result += ", "
            }
        }
        return result
    }
    
}


enum Name: CustomStringConvertible {
    case genji, mcCree
    
    var description: String {
        switch self {
        case .genji:
            return "Genji"
        case .mcCree:
            return "McCree"
        }
    }
    
    var realName: String {
        switch self {
        case .genji:
            return "Genji Shimada"
        case .mcCree:
            return "Jesse McCree"
        }
    }
    
}

enum Occupation: CustomStringConvertible {
    case adventurer, bountyHunter
    
    var description: String {
        switch self {
        case .adventurer: return "Adventurer"
        case .bountyHunter: return "Bounty Hunter"
        }
    }
}


enum BaseOfOperations: CustomStringConvertible {
    case shambali, santaFe
    
    var description: String {
        switch self {
        case .shambali: return "Shambali Monastery, Nepal"
        case .santaFe: return "Santa Fe, New Mexico, USA"
        }
    }
    
}


enum Affiliation: CustomStringConvertible {
    case shimadaClan(formerly: Bool)
    case overwatch(formerly: Bool)
    
    var description: String {
        switch self {
        case let .shimadaClan(response):
            return "Shimada Clan " + isFormerly(response)
        case let .overwatch(response):
            return "Overwatch " + isFormerly(response)
        }
    }
    
    func isFormerly(_ response: Bool) -> String {
        return response ? "(formerly)" : ""
    }
    
}
