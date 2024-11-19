    //
    //  MoreInfoView.swift
    //  dragon-api
    //
    //  Created by Lucas Prieto on 2024-11-18.
    //

    import SwiftUI
    import Kingfisher

    struct MoreInfoView: View {
        @StateObject var viewModel = MoreInfoViewModel()
        var animation : Namespace.ID
        @Binding var goBack : Bool
        @Binding var itemSelected : DragonModel.characterModel?
        @State private var showText = false
        
        var body: some View {
            GeometryReader {_ in
                ZStack {
                    Rectangle()
                        .fill(Color.red)
                        .ignoresSafeArea()
                    KFImage(URL(string:  viewModel.infoCharacter?.originPlanet.image ?? ""))
                        .placeholder {
                            Image("placeholder")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 150, height: 150)
                        }
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
                        .ignoresSafeArea()
                    ScrollView {
                        if viewModel.infoCharacter != nil {
                            VStack {
                                
                                KFImage(URL(string:  viewModel.infoCharacter?.image ?? ""))
                                    .placeholder {
                                        Image("placeholder")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 150, height: 150)
                                    }
                                    .setProcessor(DownsamplingImageProcessor(size: CGSize(width: 200, height: 200)))
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
                                Spacer()
                                VStack {
                                    Text("Descripción")
                                        .bold()
                                        .foregroundColor(.white)

                                    Text( viewModel.infoCharacter?.description ?? "")
                                        .font(.caption)
                                        .foregroundColor(.white)

                                    
                                    if let transformations = viewModel.infoCharacter?.transformations {
                                        ScrollView(.horizontal, showsIndicators: false) {
                                            LazyHStack(spacing: 100) {
                                                ForEach(transformations, id: \.id) { transformation in
                                                    GeometryReader { geometry in
                                                        let scale = getScale(proxy: geometry)
                                                        VStack {
                                                            KFImage(URL(string:  transformation.image))
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
                                                            Text(transformation.name)
                                                                .bold()
                                                                .lineLimit(nil) // Permite múltiples líneas
                                                                .foregroundColor(.white)
                                                                .padding(.bottom , 10)
                                                            
                                                        }
                                                        .padding(.horizontal , 30)
                                                        .background(Color.gray.opacity(0.2))
                                                        .cornerRadius(10)
                                                        .scaleEffect(scale)
                                                        .animation(.easeInOut, value: scale)
                                                    }
                                                    .frame(width: 200, height: 220)
                                                }
                                            }
                                            .padding(.horizontal)
                                        }
                                        .frame(height: 300)
                                    }

                                }
                                
                                
                                
                            }
                            .opacity(showText ? 1 : 0)
                            .offset(y: showText ? 0 : 20)
                            .animation(.easeInOut(duration: 0.5).delay(0.2), value: showText)
                            .padding()
                            
                            .animation(.easeInOut(duration: 0.3), value: goBack)
                            
                        }
                        
                        
                    }
                    
                }
                .frame(maxWidth: .infinity , maxHeight: .infinity)
                
                
            }
            .onTapGesture {
                goBack = false
            }
            .onAppear {
                viewModel.getCharacterByID(ID:String(itemSelected?.id ?? 1) )
                showText = true
                
            }
            .overlay(content: {
                if viewModel.showLoaging {
                    CustomProgressView()
                }
                
            })
            .matchedGeometryEffect(id: itemSelected?.image, in: animation)
        }
        
        private func getScale(proxy: GeometryProxy) -> CGFloat {
            let midX = proxy.frame(in: .global).midX
            let screenWidth = UIScreen.main.bounds.width
            let center = screenWidth / 2
            
            let distance = abs(midX - center)
            let maxScale: CGFloat = 1.3
            let minScale: CGFloat = 0.8
            let scale = max(maxScale - (distance / center) * (maxScale - minScale), minScale)
            return scale
        }
        
    }

    #Preview {
        ContentView()
    }
