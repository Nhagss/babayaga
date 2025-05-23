//
//  SettingsGridView.swift
//  babayaga
//
//  Created by Joao Roberto Fernandes Magalhaes on 15/05/25.
//
import SwiftUI

struct SettingsGridView: View {
    let assets: [String] = ["headphone", "music", "haptics", "shinyEye", "shinyEye", "shinyEye"]
    let names: [String] = ["menu-sound-effects", "menu-music", "menu-haptics", "", "", ""]
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
            let isDisabled: Bool = {
                switch index {
                case 1: return !settings.isMusicEnabled
                case 2: return !settings.isHapticsEnabled
                default: return false
                }
            }()
            
            ButtonComponent(imageName: assets[index], action: {
                switch index {
                case 1:
                    settings.isMusicEnabled.toggle()
                    AudioManager.shared.isMusicEnabled = settings.isMusicEnabled
                    if !settings.isMusicEnabled {
                        AudioManager.shared.stopSound()
                    }
                case 2:
                    settings.isHapticsEnabled.toggle()
                    if settings.isHapticsEnabled {
                        InitialScreen.complexSuccess()
                    }
                default:
                    break
                }
            })
            
            .overlay(
                Group {
                    if isDisabled {
                        Rectangle()
                            .fill(.clear)
                            .cornerRadius(10)
                            .overlay {
                                Rectangle()
                                    .foregroundStyle(.white)
                                    .frame(height: 2)
                                    .rotationEffect(.init(degrees: -45))
                            }
                    }
                }
                    .frame(alignment: .center)
            )
            .background {
                GeometryReader { geo in
                    Color.clear.onAppear {
                        DispatchQueue.main.async {
                            buttonFrames[index] = geo.frame(in: .named("canvas"))
                        }
                    }
                }
            }
            .padding(.bottom, index % 2 == 0 ? 50 : 0)
        }
    }
}


#Preview {
    SettingsView()
}
