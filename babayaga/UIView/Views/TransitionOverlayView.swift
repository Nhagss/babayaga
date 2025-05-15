//
//  TransitionView.swift
//  babayaga
//
//  Created by honorio on 15/05/25.
//

import Foundation
import SwiftUI

struct TransitionOverlayView: View {
    let level: Int
    
    var body: some View {
        VStack {
            Text("Fase \(level)")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()
            
            Text("Prepare-se para a próxima fase!")
                .font(.headline)
                .padding()
            
            Image(systemName: "arrow.right.circle.fill")
                .resizable()
                .frame(width: 100, height: 100)
                .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black.opacity(0.8))
        .foregroundColor(.white)
        .transition(.opacity)
        .ignoresSafeArea()
    }
}

#Preview {
    TransitionOverlayView(level: 2)
}
