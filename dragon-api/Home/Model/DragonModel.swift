//
//  DagonModel.swift
//  dragon-api
//
//  Created by Lucas Prieto on 2024-11-15.
//

import Foundation


struct DragonModel: Codable , Equatable {
    // Implementación de Equatable para DragonModel
    static func == (lhs: DragonModel, rhs: DragonModel) -> Bool {
        return lhs.items == rhs.items &&
               lhs.meta == rhs.meta &&
               lhs.links == rhs.links
    }
    
    var items: [characterModel]
    let meta: Meta
    var links: Links
    
    
    struct characterModel: Codable , Equatable {
            let id: Int?
            let name, ki, maxKi, race: String?
            let gender: Gender?
            let description: String?
            let image: String?
            let affiliation: Affiliation?
        
        init(id: Int? = nil, name: String? = nil, ki: String? = nil, maxKi: String? = nil, race: String? = nil, gender: Gender? = nil, description: String? = nil, image: String? = nil, affiliation: Affiliation? = nil) {
            self.id = id
            self.name = name
            self.ki = ki
            self.maxKi = maxKi
            self.race = race
            self.gender = gender
            self.description = description
            self.image = image
            self.affiliation = affiliation
        }
        
    }
    
    
    enum Gender: String, Codable {
        case female = "Female"
        case male = "Male"
    }
    
    enum Affiliation: String, Codable {
        case armyOfFrieza = "Army of Frieza"
        case freelancer = "Freelancer"
        case zFighter = "Z Fighter"
        case Villain = "Villain"
        case AssistantOfVermoud = "Assistant of Vermoud"
        case AssistantOfBeerus = "Assistant of Beerus"
        case PrideTroopers = "Pride Troopers"
        case other = "Other"
    }
    
    struct Links: Codable , Equatable {
        var first: String
        var previous: String
        var next, last: String
    }
    
    // MARK: - Meta
    struct Meta: Codable , Equatable{
        let totalItems, itemCount, itemsPerPage, totalPages: Int
        let currentPage: Int
    }
}
