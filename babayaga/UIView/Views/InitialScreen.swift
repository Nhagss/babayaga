//
//  InitialScreen.swift
//  babayaga
//
//  Created by Joao Roberto Fernandes Magalhaes on 29/04/25.
//

import SwiftUI
import SpriteKit
import CoreHaptics
import Foundation

struct InitialScreen: View {
    @ObservedObject var router = Router.shared
    @State private var engine: CHHapticEngine?
    
    var body: some View {
        NavigationStack(path: $router.path) {
            ZStack {
                Background()
                
                Image("moon")
                    .padding(.bottom, 600)
                    .padding(.leading, 250)
                
                Text("Baba")
                    .font(.custom("GermaniaOne-Regular", size: 106))
                    .padding(.bottom, 400)
                    .padding(.trailing, 70)
                    .foregroundStyle(.white)
                
                Text("Yaga")
                    .font(.custom("GermaniaOne-Regular", size: 106))
                    .padding(.bottom, 220)
                    .padding(.leading, 30)
                    .foregroundStyle(.white)
                
                VStack(spacing: 80) {
                    Button(action: {
                        router.goToGameScene()
                        complexSuccess()
                    }) {
                        PlayButton()
                            .padding(.top, 300)
                    }
                    .onAppear(perform: prepareHaptics)
                    
                    HStack(alignment:.top ,spacing: 150) {
                        ButtonComponent(imageName: "shinyEye", action: { complexSuccess() })
                            .onAppear(perform: prepareHaptics)
                        
                        // Botão da SettingsView
                        Button(action: {
                            router.goToSettingsView()
                        }) {
                            VStack {
                                    ButtonComponent(imageName: "settingsIcon", action: router.goToSettingsView)
                                Text("Ajustes")
                                    .font(.custom("Quicksand-Regular", size: 27))
                                    .foregroundStyle(.white)
                            }
                        }
                    }
                }
            }
            .navigationDestination(for: Views.self) { view in
                switch view {
                case .GameViewController:
                    GameViewControllerWrapper()
                        .ignoresSafeArea()
                        .navigationBarBackButtonHidden(true)
                case .InitialScreen:
                    InitialScreen()
                        .navigationBarBackButtonHidden(true)
                case .SettingsView:
                    SettingsView()
                }
            }
            .onAppear {
                if SettingsManager.shared.isMusicEnabled {
                    AudioManager.shared.playSound(named: "temaPrincipal")
                }
            }

            .ignoresSafeArea()
        }
        .environmentObject(router)
    }
    
    func prepareHaptics() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics,
              SettingsManager.shared.isHapticsEnabled else { return }

        do {
            engine = try CHHapticEngine()
            try engine?.start()
        } catch {
            print("Failed to create engine: \(error.localizedDescription)")
        }
    }
    
    func complexSuccess() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        
        let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: 3)
        let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: 3)
        let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: 0)
        let events = [event]
        
        do {
            let pattern = try CHHapticPattern(events: events, parameters: [])
            let player = try engine?.makePlayer(with: pattern)
            try player?.start(atTime: 0)
        } catch {
            print("Failed to play pattern: \(error.localizedDescription)")
        }
    }
}

#Preview {
    InitialScreen()
}

