//
//  SettingsView.swift
//  babayaga
//
//  Created by Joao Roberto Fernandes Magalhaes on 05/05/25.
//

import SwiftUI

struct SettingsView: View {

    @State private var buttonFrames: [CGRect] = Array(repeating: .zero, count: 6)
    let assets : [String] = ["headphone", "music","haptics","restore", "noads", "oppelt" ]
    var body: some View {
        ZStack {

            Background()
                .blur(radius: 5)
            
          // MARK: Formação das teias
            Path { path in
                let pairs = [(0, 1), (1, 2), (2, 5), (3,4), (4,5)]

                for (first, second) in pairs {
                    let frame1 = buttonFrames[first]
                    let frame2 = buttonFrames[second]

                    if (first, second) == (1, 2) || (first, second) == (4, 5) {
                        path.move(to: CGPoint(x: frame2.midX, y: frame2.midY - 40))
                        path.addLine(to: CGPoint(x: frame1.midX, y: frame1.midY - 10))

                        path.move(to: CGPoint(x: frame2.midX , y: frame2.midY - 30))
                        path.addLine(to: CGPoint(x: frame1.midX, y: frame1.midY))

                        path.move(to: CGPoint(x: frame2.midX - 10, y: frame2.midY - 35))
                        path.addLine(to: CGPoint(x: frame1.midX + 10, y: frame1.midY - 8))

                        path.move(to: CGPoint(x: frame2.midX + 20, y: frame2.midY - 30))
                        path.addLine(to: CGPoint(x: frame1.midX + 10, y: frame1.midY - 15))

                    }
                    else if (first, second) == (2, 5) {
                        path.move(to: CGPoint(x: frame1.midX - 10, y: frame1.midY))
                        path.addLine(to: CGPoint(x: frame2.midX - 10, y: frame2.midY))
                        
                        path.move(to: CGPoint(x: frame1.midX - 10, y: frame1.midY))
                        path.addLine(to: CGPoint(x: frame2.midX, y: frame2.midY))
                        
                        path.move(to: CGPoint(x: frame1.midX, y: frame1.midY))
                        path.addLine(to: CGPoint(x: frame2.midX  - 10, y: frame2.midY))
                        
                        path.move(to: CGPoint(x: frame1.midX + 5 , y: frame1.midY))
                        path.addLine(to: CGPoint(x: frame2.midX + 5, y: frame2.midY))
                        
                        
                    }
                    else {
                        path.move(to: CGPoint(x: frame1.midX, y: frame1.midY - 40))
                        path.addLine(to: CGPoint(x: frame2.midX, y: frame2.midY + 10))

                        path.move(to: CGPoint(x: frame1.midX , y: frame1.midY - 30))
                        path.addLine(to: CGPoint(x: frame2.midX, y: frame2.midY))

                        path.move(to: CGPoint(x: frame1.midX + 10, y: frame1.midY - 30))
                        path.addLine(to: CGPoint(x: frame2.midX - 10, y: frame2.midY + 10))
                    }
                }
            }
            .stroke(Color.white, lineWidth: 2)

            VStack(spacing: 100) {
                HStack(spacing: 40) {
                    ForEach(0..<3) { index in
                        ZStack{
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
                            Image(assets[index])
                                .padding(.bottom, index % 2 == 0 ? 50 : 0)
                    }
                    }
                }

                HStack(spacing: 40) {
                    ForEach(3..<6) { index in
                        ZStack{
                            ButtonComponent()
                                .padding(.bottom, index % 2 == 0 ? 0 : 50)
                                .background {
                                    GeometryReader { geo in
                                        Color.clear.onAppear {
                                            DispatchQueue.main.async {
                                                buttonFrames[index] = geo.frame(in: .named("canvas"))
                                            }
                                        }
                                    }
                                }
                            Image(assets[index])
                                .resizable()
                                .frame(width: 60, height: 60)
                                .padding(.bottom, index % 2 == 0 ? 0 : 50)
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
