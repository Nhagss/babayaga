//
//  SettingsView.swift
//  babayaga
//
//  Created by Joao Roberto Fernandes Magalhaes on 05/05/25.
//

import SwiftUI

struct SettingsView: View {
    @State private var buttonFrames: [CGRect] = Array(repeating: .zero, count: 6)

    var body: some View {
        ZStack {
            Background().blur(radius: 5)

            ConnectionPathView(buttonFrames: buttonFrames)
            SettingsGridView(buttonFrames: $buttonFrames) 
        }
        .coordinateSpace(name: "canvas")
    }
}



#Preview {
    SettingsView()
}
