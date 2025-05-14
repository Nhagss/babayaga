//
//  ButtonComponent.swift
//  babayaga
//
//  Created by Joao Roberto Fernandes Magalhaes on 04/05/25.
//

import SwiftUI

struct ButtonComponent: View {
    
    var image: ImageResource
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Circle()
                .fill(Color.black)
                .strokeBorder(.white, lineWidth: 2)
                .frame(width: 80, height: 80) 
                .overlay {
                    Image(image)
                }
        }
    }
}

#Preview {
    ButtonComponent(image: .reverseButton, action: {})
}
