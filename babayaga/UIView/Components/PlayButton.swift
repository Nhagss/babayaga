//
//  PlayButton.swift
//  babayaga
//
//  Created by Joao Roberto Fernandes Magalhaes on 04/05/25.
//

import SwiftUI

struct PlayButton: View {
    @State private var isBlinking = false
    
    var body: some View {
        VStack {
            ZStack {
                
                Image("play")
                
                Image("eye.play")
                    .scaleEffect(y: isBlinking ? 1 : 0, anchor: .center)
                    .animation(.bouncy(duration: 0.4), value: isBlinking)
                    .padding(.trailing, 10)
                    .onAppear {
                        func scheduleNextBlink() {
                            let delay = Double.random(in: 0.05...2.5)
                            DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                                isBlinking.toggle()
                                scheduleNextBlink()
                            }
                        }
                        scheduleNextBlink()
                    }
                
            }
        }
    }
}

#Preview {
    PlayButton()
}
