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
@ObservedObject private var router = Router.shared
  @State private var engine: CHHapticEngine?

    var body: some View {
        NavigationStack (path: $router.path) {
            
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
                    Button(action:  {
                        router.goToGameScene()
                        complexSuccess()
                    }){
                        PlayButton()
                            .padding(.top, 300)
                        
                            .navigationDestination(for: Views.self) { view in
                                switch view {
                                case .GameViewController:
                                    GameViewControllerWrapper()
                                        .navigationBarBackButtonHidden(true)
                                        .onAppear {
                                            AudioManager.shared.playSound(named: "fasesIniciais")
                                        }
                                        .ignoresSafeArea()
                                case .InitialScreen:
                                    GameViewControllerWrapper()
                                        .navigationBarBackButtonHidden(true)
                                        .onAppear {
                                            AudioManager.shared.playSound(named: "fasesIniciais")
                                        }
                                        .ignoresSafeArea()
                                }
                            }
                            .navigationBarBackButtonHidden(true)
                            .onAppear {
                                AudioManager.shared.playSound(named: "temaPrincipal")
                            }
                    }
                    .onAppear(perform: prepareHaptics)
                    
                    HStack(spacing: 150){
                        ButtonComponent(image: .shinyEye, action: {complexSuccess()})
                            .onAppear(perform: prepareHaptics)
                        ButtonComponent(image: .shinyEye, action: {complexSuccess()})
                            .onAppear(perform: prepareHaptics)
                    }
                }
            }
            .ignoresSafeArea()
            .navigationDestination(for: Views.self) { view in
                switch view {
                case .GameViewController:
                    GameViewControllerWrapper()
                        .ignoresSafeArea()
                        .navigationBarBackButtonHidden()
                case .InitialScreen:
                    InitialScreen()
                        .navigationBarBackButtonHidden(true)
                }
            }
        }
        .environmentObject(router)
        
        
    }
    
    func prepareHaptics() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        
        do {
            engine = try CHHapticEngine()
            try engine?.start()
        } catch {
            print("Failed to create engine: \(error.localizedDescription)")
        }
    }
    func complexSuccess() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        
        let intensity = CHHapticEventParameter(parameterID: .hapticIntensity , value: 3)
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
