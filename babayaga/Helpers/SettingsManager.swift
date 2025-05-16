//
//  SettingsManager.swift
//  babayaga
//
//  Created by Joao Roberto Fernandes Magalhaes on 15/05/25.
//
import Foundation
import SwiftUI

class SettingsManager: ObservableObject {
    static let shared = SettingsManager()
    
    @Published var isMusicEnabled: Bool = true {
        didSet {
            if !isMusicEnabled {
                AudioManager.shared.stopSound()
            } else {
                AudioManager.shared.playSound(named: "temaPrincipal")
            }
        }
    }
    
    @Published var isHapticsEnabled: Bool = true
}
