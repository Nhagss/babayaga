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
            Background()
                .blur(radius: 5)
            
            Path { path in
                let pairs = [(0, 1), (1, 2)]

                for (first, second) in pairs {
                    let frame1 = buttonFrames[first]
                    let frame2 = buttonFrames[second]
                    
                    if (first, second) == (1, 2) {
                        // Inverso: de baixo pra cima
                        path.move(to: CGPoint(x: frame2.midX, y: frame2.midY - 40))
                        path.addLine(to: CGPoint(x: frame1.midX, y: frame1.midY - 10))
                        
                        path.move(to: CGPoint(x: frame2.midX , y: frame2.midY - 30))
                        path.addLine(to: CGPoint(x: frame1.midX, y: frame1.midY))
                        
                        path.move(to: CGPoint(x: frame2.midX - 10, y: frame2.midY - 35))
                        path.addLine(to: CGPoint(x: frame1.midX + 10, y: frame1.midY - 8))
                        
                        path.move(to: CGPoint(x: frame2.midX + 20, y: frame2.midY - 30))
                        path.addLine(to: CGPoint(x: frame1.midX + 10, y: frame1.midY - 15))
                        
                    } else {
                        // Normal: de cima pra baixo
                        path.move(to: CGPoint(x: frame1.midX, y: frame1.midY - 40))
                        path.addLine(to: CGPoint(x: frame2.midX, y: frame2.midY + 10))
                        
                        path.move(to: CGPoint(x: frame1.midX , y: frame1.midY - 30))
                        path.addLine(to: CGPoint(x: frame2.midX, y: frame2.midY))
                        
                        path.move(to: CGPoint(x: frame1.midX + 10, y: frame1.midY - 30))
                        path.addLine(to: CGPoint(x: frame2.midX - 10, y: frame2.midY + 10))
                    }
                }
            }
            .stroke(Color.white.opacity(0.8), lineWidth: 2)

            VStack(spacing: 100) {
                HStack(spacing: 40) {
                    ForEach(0..<3) { index in
                        ButtonComponent()
                            .padding(.bottom, index % 2 == 0 ? 50 : 0)
                            .background {
                                GeometryReader { geo in
                                    Color.clear.onAppear {
                                        DispatchQueue.main.async {
                                            buttonFrames[index] = geo.frame(in: .named("canvas"))
                                        }
                                    }
                                }
                            }
                    }
                }
                
                HStack(spacing: 40) {
                    ForEach(0..<3) { index in
                        ButtonComponent()
                            .padding(.bottom, index % 2 == 0 ? 50 : 0)
                            .background {
                                GeometryReader { geo in
                                    Color.clear.onAppear {
                                        DispatchQueue.main.async {
                                            buttonFrames[index] = geo.frame(in: .named("canvas"))
                                        }
                                    }
                                }
                            }
                    }
                }
            }
        }
        .coordinateSpace(name: "canvas")
    }
}


#Preview {
    SettingsView()
}

