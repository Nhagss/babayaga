//
//  ButtonComponent.swift
//  babayaga
//
//  Created by Joao Roberto Fernandes Magalhaes on 04/05/25.
//

import SwiftUI

struct ButtonComponent: View {
    var body: some View {
        ZStack {
            Circle()
                .fill(Color.black) 
                .overlay(
                    Circle()
                        .stroke(Color.white, lineWidth: 2)
                )
                .frame(width: 80, height: 80) 
        }
    }
}

#Preview {
    ButtonComponent()
}
