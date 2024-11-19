//
//  DragonCharacterModel.swift
//  dragon-api
//
//  Created by Lucas Prieto on 2024-11-18.
//

import Foundation

struct DragonCharacter: Codable {
    let id: Int
    let name, ki, maxKi, race: String
    let gender, description: String
    let image: String
    let affiliation: String
    let originPlanet: OriginPlanet
    let transformations: [Transformation]
}

// MARK: - OriginPlanet
struct OriginPlanet: Codable {
    let id: Int
    let name: String
    let isDestroyed: Bool
    let description: String
    let image: String
}

// MARK: - Transformation
struct Transformation: Codable {
    let id: Int
    let name: String
    let image: String
    let ki: String
}
