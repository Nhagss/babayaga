//
//  LevelsView.swift
//  babayaga
//
//  Created by honorio on 16/05/25.
//

import SwiftUI
import CoreHaptics

struct LevelsView: View {
    @ObservedObject var router = Router.shared
    @ObservedObject var gameSceneManager = GameSceneManager.shared
    @State private var engine: CHHapticEngine?

    private let levels = Array(1...15)
    private let adaptiveColumns = [
        GridItem(.adaptive(minimum: 100))
    ]
    
    var body: some View {
        VStack {
            Text("Níveis")
                .font(.custom("GermaniaOne-Regular", size: 60))
                .foregroundColor(.accent)
            LazyVGrid(columns: adaptiveColumns, spacing: 20) {
                ForEach(levels, id: \.self) { level in
                    Button {
                        if isLevelUnlocked(level: level) {
                            complexSuccess()
                            gameSceneManager.currentLevel = level
                            router.goToGameScene()
                        }
                    } label: {
                        Circle()
                            .fill(.black)
                            .strokeBorder(.white, lineWidth: 2)
                            .frame(width: 80, height: 80)
                            .overlay {
                                if isLevelUnlocked(level: level) {
                                    Text("\(level)")
                                        .font(.custom("GermaniaOne-Regular", size: 40))
                                        .foregroundColor(.white)
                                } else {
                                    Image("levelLockedIcon")
                                        .resizable()
                                        .frame(width: 80, height: 80)
                                }
                            }
                    }
                    .onAppear(perform: prepareHaptics)
                    .disabled(!isLevelUnlocked(level: level))
                }
            }
            .padding()
        }
        .vSpacing(.top)
        .background {
            Background()
        }
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
    
    private func isLevelUnlocked(level: Int) -> Bool {
        let completedLevels = UserDefaults.standard.array(forKey: gameSceneManager.keyForUserDefaults) as? [Int] ?? []
        let highestCompleted = completedLevels.max() ?? 0
        return level <= highestCompleted + 1
    }
}

#Preview {
    NavigationStack {
        LevelsView()
    }
}
