//
//  GrannyAnimation.swift
//  POCGrannyAnimation
//
//  Created by Yago Souza Ramos on 5/14/25.
//

import SwiftUI
import RiveRuntime
struct GrannyAnimation: View {
    var body: some View {
        VStack {
            GeometryReader { geo in
                VStack(spacing: 0) {
                    Text("Fase")
                        .font(.custom("Quicksand-Regular", size: 38))
                    Text("1")
                        .font(.custom("GermaniaOne-Regular", size: 110))
                }
                .position(x: geo.size.width/2, y: geo.size.height*0.15)
                .foregroundStyle(.white)
                RiveViewModel(fileName: "GrannyPullsUpCrop").view().frame(minWidth: geo.size.width*2)
                    .position(x:geo.size.width/2, y: geo.size.height*0.7)
            }
        }
        .background(Background())
    }
}

#Preview {
    GrannyAnimation()
}
