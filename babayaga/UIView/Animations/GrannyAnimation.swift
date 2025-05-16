//
//  GrannyAnimation.swift
//  POCGrannyAnimation
//
//  Created by Yago Souza Ramos on 5/14/25.
//

import SwiftUI
import RiveRuntime
struct GrannyAnimation: View {
    var phaseNumber: Int = 2
    
    @State private var animateUp: Bool = true
    @State private var animateSize: Bool = true
    @State private var isPlaying: Bool = false
    
    @State var riveVM: RiveViewModel = RiveViewModel(
        fileName: "GrannyPullsUpCrop"
    )

    var body: some View {
        GeometryReader { geo in
            ZStack {
                VStack(spacing: 0) {
                    Text("Fase")
                        .font(.custom("Quicksand-Regular", size: geo.size.width * (animateSize ? 0.15 : 0.15 * 1.6)))
                    Text("\(phaseNumber)")
                        .font(.custom("GermaniaOne-Regular", size: geo.size.width * (animateSize ? 0.25 : 0.25 * 1.6)))
                }
                .position(x: geo.size.width/2)
                .offset(y: geo.size.height * (animateUp ? 1.3 : 0.2))
                .foregroundStyle(.white)
                
                riveVM
                    .view()
                    .frame(minWidth: geo.size.width*2)
                    .position(x: geo.size.width/2)
                    .offset(y:geo.size.height * 0.7)
                    .opacity(riveVM.isPlaying ? 1 : 0)
            }
            .onAppear() {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    withAnimation(.bouncy(duration: 1)) {
                        animateUp = false
                        
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.45) {
                        withAnimation(.easeInOut(duration: 0.32)) {
                            animateSize = false
                        }
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.9) {
                        withAnimation(.easeInOut(duration: 0.5)) {
                            animateSize = true
                        }
                    }
                }
            }
//            .onChange(of: isPlaying) { _, _ in
//                if isPlaying {
//                    print("caiu aqui")
//                    riveVM.reset()
//                }
//            }
        }
        
        .background(Background())
    }
    
    func play() {
        print(riveVM.isPlaying)
        riveVM.play()
        riveVM.reset()
        print(riveVM.isPlaying)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            riveVM.stop()
        }
    }
}

#Preview {
    GrannyAnimation()
}
