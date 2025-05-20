//
//  Character.swift
//  babayaga
//
//  Created by Joao Roberto Fernandes Magalhaes on 16/05/25.
//

import Foundation
import SpriteKit

enum CharacterSkin: String, CaseIterable {
    case morgana
    case oppelt

    var displayName: String {
        switch self {
        case .morgana: return "Morgana"
        case .oppelt: return "Oppelt"
        }
    }

    var imageAssets: (head: String, torso: String, frontArm: String, backArm: String, foot: String) {
        return (
            head: "\(rawValue)_head",
            torso: "\(rawValue)_torso",
            frontArm: "\(rawValue)_frontArm",
            backArm: "\(rawValue)_backArm",
            foot: "\(rawValue)_foot"
        )
    }
}

