//
//  background.swift
//  babayaga
//
//  Created by Joao Roberto Fernandes Magalhaes on 02/05/25.
//

import SwiftUI

struct Background: View {
    var body: some View {
        ZStack {
            Image("background")
                .resizable()
            
            Image("arvores")
                .resizable()
            
            Image("bigarvore")
                .resizable()
            
            Image("bigarvore2")
                .scaledToFill()
                .padding(.top, 346)
                .padding(.leading, 200)
            
            Image("eyefundo")
                .padding(.top, 10)
                .padding(.leading, 300)
            
            Image("eyefundo")
                .padding(.bottom, 700)
                .padding(.trailing, 270)
            
            Image("vector")
                .resizable()
            
            Image("textura")
                .resizable()
        }
        
    }
}

#Preview {
    Background()
}
