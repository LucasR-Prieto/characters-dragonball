//
//  HomeViewModel.swift
//  dragon-api
//
//  Created by Lucas Prieto on 2024-11-17.
//

import Foundation
import SwiftUI


class HomeViewModel: ObservableObject {
    @Published var listCharacter:DragonModel? = nil
    @Published var showLoaging = false
    @Published var showItems = false
    @Published var itemSelected:DragonModel.characterModel? = nil

    
    

    func getCharacters () {
        self.showLoaging = true
        HTTPClient.shared.getRequest(endpoint: "/characters") { (result: Result<DragonModel, Error>) in
            switch result {
            case .success(let characters):
                self.showLoaging = false
                self.listCharacter = characters
                self.showItems = true
            case .failure(_):
                self.showLoaging = false
                print("Error al obtener los personajes ")
            }
        }
    }
    
    func getCharacters (url: String) {
        var finalUrl = url.replacingOccurrences(of: "https://dragonball-api.com/api", with: "")
        self.showLoaging = true
        HTTPClient.shared.getRequest(endpoint: finalUrl) { (result: Result<DragonModel, Error>) in
            switch result {
            case .success(let characters):
                self.showLoaging = false
                self.listCharacter?.items.append(contentsOf: characters.items)
                self.listCharacter?.links = characters.links
                self.showItems = true
            case .failure(let error):
                self.showLoaging = false
                print(error)
            }
        }
    }
    func getCharacterByID (ID : String ){
        self.showLoaging = true
        HTTPClient.shared.getRequest(endpoint: "/characters/\(ID)") { (result: Result<DragonModel, Error>) in
            switch result {
            case .success(let characters):
                self.showLoaging = false
                self.listCharacter = characters
                self.showItems = true
            case .failure(_):
                self.showLoaging = false
                print("Error al obtener los personajes ")
            }
        }
    }
}
