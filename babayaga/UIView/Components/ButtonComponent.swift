//
//  ButtonComponent.swift
//  babayaga
//
//  Created by Joao Roberto Fernandes Magalhaes on 04/05/25.
//

import SwiftUI

struct ButtonComponent: View {
    var imageName: String
    var action: () -> Void
    
    init(imageName: String, action: @escaping () -> Void) {
        self.imageName = imageName
        self.action = action
    }

    var body: some View {
        Button(action: action) {
            Circle()
                .fill(Color.black)
                .overlay(
                    Image(imageName)
                        .resizable()
                        .scaledToFit()
                        .padding(15)
                )
                .frame(width: 80, height: 80)
                .overlay(
                    Circle().stroke(.white, lineWidth: 2)
                )
        }
    }
}


