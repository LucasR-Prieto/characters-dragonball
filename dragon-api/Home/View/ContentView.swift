//
//  ContentView.swift
//  dragon-api
//
//  Created by Lucas Prieto on 2024-11-15.
//

import SwiftUI
import Kingfisher

struct ContentView: View {
    @StateObject var viewModel = HomeViewModel()
    @State private var showItems: Bool = false 
    @Namespace private var animation
    @State var goToMoreInfo = false
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.red)
                .ignoresSafeArea()
            
            // Imagen de fondo
            Image("namek1")
                .resizable()
                .ignoresSafeArea()
            
            VStack {
                if let characters = viewModel.listCharacter?.items {
                    List(characters, id: \.id) { character in
                        ItemCharacter(character: character, itemSelected: $viewModel.itemSelected, goToMoreInfo: $goToMoreInfo , animation: animation )
                            .opacity(viewModel.showItems ? 1 : 0)
                            .scaleEffect(viewModel.showItems ? 1 : 0.8)
                            .animation(.easeInOut(duration: 0.9), value: viewModel.showItems)
                            .listRowBackground(Color.clear)
                            .onAppear{
                                if character == characters.last {
                                    if let nextPage =  viewModel.listCharacter?.links.next {
                                        viewModel.getCharacters(url: nextPage)
                                    }
                                }
                            }
                    }
                    
                    .scrollContentBackground(.hidden)
                }
            }
        }
        .overlay {
            if viewModel.showLoaging {
                CustomProgressView()
            }
            if goToMoreInfo {
                MoreInfoView(animation: animation, goBack: $goToMoreInfo, itemSelected : $viewModel.itemSelected )
                    .transition(.asymmetric(insertion: .identity, removal: .offset(y: -5)))
                
            }
        }
        .onAppear {
            viewModel.getCharacters()
            
        }
    }
}


#Preview {
    ContentView()
}
