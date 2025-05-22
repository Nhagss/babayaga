//
//  SettingsGridView.swift
//  babayaga
//
//  Created by Joao Roberto Fernandes Magalhaes on 15/05/25.
//
import SwiftUI

struct SettingsGridView: View {
    let assets: [String] = ["headphone", "music", "haptics", "shinyEye", "shinyEye", "shinyEye"]
    @Binding var buttonFrames: [CGRect]
    
    @EnvironmentObject var settings: SettingsManager

    var body: some View {
        VStack(spacing: 100) {
            HStack(spacing: 40) {
                ForEach(0..<3) { index in
                    buttonView(index: index)
                }
            }

            HStack(spacing: 40) {
                ForEach(3..<6) { index in
                    buttonView(index: index)
                }
            }

            NavigationLink(destination: CreditsView()) {
                Text("settings_grid_credits")
                    .foregroundStyle(.white)
                    .bold()
                    .underline(true , color: .white)
            }
        }
    }

    @ViewBuilder
    func buttonView(index: Int) -> some View {
        ZStack {
            ButtonComponent(imageName: assets[index], action: {
                switch index {
                case 1:
                    settings.isMusicEnabled.toggle()
                case 2:
                    settings.isHapticsEnabled.toggle()
                default:
                    break
                }
            })
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


