//
//  MoreInfoViewModel.swift
//  dragon-api
//
//  Created by Lucas Prieto on 2024-11-18.
//

import Foundation

class MoreInfoViewModel: ObservableObject { 
    @Published var showLoaging = false
    @Published var showItems = false
    var infoCharacter : DragonCharacter? = nil
    
    
    func getCharacterByID (ID : String ){
        self.showLoaging = true
        HTTPClient.shared.getRequest(endpoint: "/characters/\(ID)") { (result: Result<DragonCharacter, Error>) in
            switch result {
            case .success(let characters):
                self.showLoaging = false
                self.infoCharacter = characters
                self.showItems = true
            case .failure(_):
                self.showLoaging = false
                print("Error al obtener los personajes ")
            }
        }
    }


    
}
