//
//  ItemCharacter.swift
//  dragon-api
//
//  Created by Lucas Prieto on 2024-11-17.
//

import SwiftUI
import Kingfisher

struct ItemCharacter: View {
    let character: DragonModel.characterModel
    @State private var showImage = false
    @Binding var itemSelected : DragonModel.characterModel?
    @Binding var goToMoreInfo : Bool
    var animation : Namespace.ID

    
    var body: some View {
        ZStack {
            VStack(spacing: 50) {
                Spacer()
                
                VStack {
                    
                    HStack {
                        Text(character.name ?? "")
                            .font(.headline)
                            .foregroundColor(.white)
                        
                        Spacer()
                        
                        Text(character.affiliation?.rawValue ?? "")
                            .font(.headline)
                            .foregroundColor(.white)
                    }
                    
                    HStack {
                        Text("Raza :\(character.race ?? "")")
                            .font(.headline)
                            .foregroundColor(.white)
                        
                        Spacer()
                        
                        Text("ki: \(character.ki ?? "")")
                            .font(.headline)
                            .foregroundColor(.white)
                    }
                }
            }

            .padding([.horizontal, .bottom])
            .frame(maxWidth: .infinity)
            .frame(height: 220)
            .background(Color.blue)
            .cornerRadius(15)
            .shadow(radius: 10)
            
            ZStack {
                if showImage {
//                    GeometryReader {_ in
                    KFImage(URL(string: character.image ?? ""))
                        .placeholder {
                            Image("placeholder")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 150, height: 150)
                        }
                        .setProcessor(DownsamplingImageProcessor(size: CGSize(width: 200, height: 200)))
                        .fade(duration: 0.25)
                        .cacheMemoryOnly()
                        .onProgress { receivedSize, totalSize in
                            print("Progreso: \(receivedSize)/\(totalSize)")
                        }
                        .onSuccess { result in
                            print("Cargado: \(result.image)")
                        }
                        .onFailure { error in
                            print("Error: \(error.localizedDescription)")
                        }
                        .resizable()
                        .scaledToFit()
                        .frame(width: 220, height: 220)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .matchedGeometryEffect(id: character.image ?? "", in: animation)

                    //
                    //                        Image("imageTest")
                    //                            .resizable()
                    //                            .frame(width: 160, height: 250)
//                }

                    
                }

            }

            .frame(maxWidth: .infinity)
            .padding(.bottom, 150)
        }
        .onTapGesture {
            itemSelected = character
            goToMoreInfo = true
        }
        .onAppear {
            withAnimation(.easeInOut(duration: 0.5)) {
                showImage = true
            }
        }
    }
}

#Preview {
    ContentView()
}


