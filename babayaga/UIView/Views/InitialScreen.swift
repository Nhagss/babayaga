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
    @State public static var engine: CHHapticEngine?
    
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
                        router.goToChooseCharacter()
                    } label: {
                        PlayButton()
                            .padding(.top, 300)
                    }
                    
                    HStack(alignment:.top ,spacing: 150) {
                        VStack {
                            ButtonComponent(imageName: "levelsIcon") {
                                InitialScreen.complexSuccess()
                                router.goToLevelsView()
                            }
                            Text("initial_screen_levels")
                                .font(.custom("Quicksand-Regular", size: 27))
                                .foregroundStyle(.white)
                        }
                        
                        // Botão da SettingsView
                        VStack {
                            ButtonComponent(imageName: "settingsIcon") {
                                InitialScreen.complexSuccess()
                                router.goToSettingsView()
                            }
                            Text("initial_screen_settings")
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
                case .ChooseCharacter:
                    ChooseCharacter()
                case .LevelsView:
                    LevelsView()
                default:
                    EmptyView()
                }
            }
            .onAppear {
                if SettingsManager.shared.isMusicEnabled {
                    AudioManager.shared.playSound(named: "temaPrincipal")
                }
                InitialScreen.prepareHaptics()
            }
            
            .ignoresSafeArea()
        }
        .environmentObject(router)
    }
    
    public static func startGame() {
        let router = Router.shared
        let gameSceneManager = GameSceneManager.shared
        
        if CHHapticEngine.capabilitiesForHardware().supportsHaptics {
            let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: 3)
            let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: 3)
            let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: 0)
            let events = [event]
            
            do {
                let engine = try CHHapticEngine()
                try engine.start()
                let player = try engine.makePlayer(with: try CHHapticPattern(events: events, parameters: []))
                try player.start(atTime: 0)
            } catch {
                print("Failed to play pattern: \(error.localizedDescription)")
            }
        }
        
        let keyForUserDefaults = "completedLevels"
        if let encodedData = UserDefaults.standard.array(forKey: keyForUserDefaults) as? [Int], !encodedData.isEmpty {
            gameSceneManager.currentLevel = (encodedData.max() ?? 0) + 1
        } else {
            gameSceneManager.currentLevel = 1
        }
        
        router.goToGameScene()
    }
    
    public static func prepareHaptics() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics,
              SettingsManager.shared.isHapticsEnabled else { return }
        
        do {
            InitialScreen.engine = try CHHapticEngine()
            try InitialScreen.engine?.start()
        } catch {
            print("Failed to create engine: \(error.localizedDescription)")
        }
    }
    
    public static func complexSuccess() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics,
              SettingsManager.shared.isHapticsEnabled else { return }
        
        let intensity = CHHapticEventParameter(parameterID: .hapticIntensity , value: 1.0)
        let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: 1.0)
        let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: 0)
        
        do {
            let engine = try CHHapticEngine()
            try engine.start()
            let pattern = try CHHapticPattern(events: [event], parameters: [])
            let player = try engine.makePlayer(with: pattern)
            try player.start(atTime: 0)
        } catch {
            print("Failed to play haptic pattern: \(error.localizedDescription)")
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
