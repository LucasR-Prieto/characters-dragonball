//
//  CustomProgressView.swift
//  dragon-api
//
//  Created by Lucas Prieto on 2024-11-17.
//

import SwiftUI

struct CustomProgressView: View {
    var body: some View {
        ZStack {
            // Fondo oscuro semi-transparente
            Color.black
                .opacity(0.5)
                .ignoresSafeArea()
                .allowsHitTesting(false) // El fondo no responde a toques
            
            // Contenedor del ProgressView
            VStack(spacing: 20) {
                ProgressView() // Indicador de progreso circular predeterminado
                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                    .scaleEffect(1.5) // Tamaño del indicador
                
                Text("Cargando...")
                    .foregroundColor(.white)
                    .font(.headline)
            }
            
            .padding(30)
            .background(
                RoundedRectangle(cornerRadius: 15)
                    .fill(Color.gray.opacity(0.9)) // Fondo del ProgressView
            )
            .shadow(radius: 10) // Sombra para darle un efecto elegante
        }
    }
}


#Preview {
    CustomProgressView()
}
