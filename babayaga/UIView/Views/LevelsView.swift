//
//  LevelsView.swift
//  babayaga
//
//  Created by honorio on 16/05/25.
//

import SwiftUI

struct LevelsView: View {
    @ObservedObject var router = Router.shared
    @ObservedObject var gameSceneManager = GameSceneManager.shared
    private let levels = Array(1...10)
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
                        if isLevelCompleted(level: level) {
                            gameSceneManager.currentLevel = level
                            router.goToGameScene()
                        }
                    } label: {
                        Circle()
                            .fill(.black)
                            .strokeBorder(.white, lineWidth: 2)
                            .frame(width: 80, height: 80)
                            .overlay {
                                if isLevelCompleted(level: level) {
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
                    .disabled(!isLevelCompleted(level: level))
                }
            }
            .padding()
        }
        .vSpacing(.top)
        .background {
            Background()
        }
    }
    
    private func isLevelCompleted(level item: Int) -> Bool {
        let encodedData = UserDefaults.standard.array(forKey: gameSceneManager.keyForUserDefaults) as? [Int] ?? []
        return encodedData.contains(item)
    }
}

#Preview {
    NavigationStack {
        LevelsView()
    }
}
