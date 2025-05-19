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
    @ObservedObject var gameSceneManager = GameSceneManager.shared
    @State private var engine: CHHapticEngine?
    
    let keyForUserDefaults = "completedLevels"
    
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
                    Button {
                        complexSuccess()
                        // Se não encontrar nenhum nível salvo, começa do nível 1
                        gameSceneManager.currentLevel = loadLastLevel() ?? 1
                        router.goToGameScene()
                    } label: {
                        PlayButton()
                            .padding(.top, 300)
                    }
                    .onAppear(perform: prepareHaptics)
                    
                    HStack(alignment:.top ,spacing: 150) {
                        VStack {
                            ButtonComponent(imageName: "levelsIcon") {
                                complexSuccess()
                                router.goToLevelsView()
                            }
                            .onAppear(perform: prepareHaptics)
                            Text("Níveis")
                                .font(.custom("Quicksand-Regular", size: 27))
                                .foregroundStyle(.white)
                        }
                        
                        // Botão da SettingsView
                        VStack {
                            ButtonComponent(imageName: "settingsIcon") {
                                complexSuccess()
                                router.goToSettingsView()
                            }
                            .onAppear(perform: prepareHaptics)
                            Text("Ajustes")
                                .font(.custom("Quicksand-Regular", size: 27))
                                .foregroundStyle(.white)
                        }
                    }
                }
            }
            .navigationDestination(for: Views.self) { view in
                switch view {
                case .RestartGame:
                    GameViewControllerWrapper()
                        .navigationBarBackButtonHidden(true)
                        .ignoresSafeArea()
                case .GameViewController:
                    GameViewControllerWrapper()
                        .navigationBarBackButtonHidden(true)
                        .ignoresSafeArea()
                case .InitialScreen:
                    InitialScreen()
                        .navigationBarBackButtonHidden(true)
                case .SettingsView:
                    SettingsView()
                case .LevelsView:
                    LevelsView()
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
    
    private func prepareHaptics() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics,
              SettingsManager.shared.isHapticsEnabled else { return }

        do {
            engine = try CHHapticEngine()
            try engine?.start()
        } catch {
            print("Failed to create engine: \(error.localizedDescription)")
        }
    }
    
    private func complexSuccess() {
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
    
    private func loadLastLevel() -> Int? {
        guard let encodedData = UserDefaults.standard.array(forKey: keyForUserDefaults) as? [Int], !encodedData.isEmpty else {
            return nil
        }
        
        return (encodedData.max() ?? 0) + 1
    }
}

#Preview {
    InitialScreen()
}

