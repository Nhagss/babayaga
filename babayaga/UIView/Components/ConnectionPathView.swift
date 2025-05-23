//
//  ConnectionPathView.swift
//  babayaga
//
//  Created by Joao Roberto Fernandes Magalhaes on 15/05/25.
//

import SwiftUI

struct ConnectionPathView: View {
    let buttonFrames: [CGRect]
    
    var body: some View {
        Path { path in
            let pairs = [(0, 1), (1, 2), (2, 5), (3, 4), (4, 5)]
            
            for (first, second) in pairs {
                let frame1 = buttonFrames[first]
                let frame2 = buttonFrames[second]
                
                if (first, second) == (2, 5) {
                    path.move(to: CGPoint(x: frame1.midX - 10, y: frame1.midY - 5))
                    path.addLine(to: CGPoint(x: frame2.midX - 5, y: frame2.midY + 5))
                    path.move(to: CGPoint(x: frame1.midX - 5, y: frame1.midY + 5))
                    path.addLine(to: CGPoint(x: frame2.midX, y: frame2.midY - 5))
                    path.move(to: CGPoint(x: frame1.midX + 10, y: frame1.midY))
                    path.addLine(to: CGPoint(x: frame2.midX - 10, y: frame2.midY))
                } else {
                    path.move(to: CGPoint(x: frame1.midX + 10, y: frame1.midY + 10))
                    path.addLine(to: CGPoint(x: frame2.midX - 10, y: frame2.midY + 5))
                    path.move(to: CGPoint(x: frame1.midX - 12, y: frame1.midY - 10))
                    path.addLine(to: CGPoint(x: frame2.midX + 12, y: frame2.midY - 5))
                    path.move(to: CGPoint(x: frame1.midX + 5, y: frame1.midY - 5))
                    path.addLine(to: CGPoint(x: frame2.midX - 5, y: frame2.midY + 10))
                }
            }
        }
        .stroke(Color.white, lineWidth: 2)
    }
}

#Preview {
    SettingsView()
}
