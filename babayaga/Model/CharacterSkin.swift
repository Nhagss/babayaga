//
//  CharacterSkin.swift
//  babayaga
//
//  Created by Joao Roberto Fernandes Magalhaes on 21/05/25.
//

import Foundation

enum CharacterSkin: String, CaseIterable {
    case morgana
    case rasputin

    var displayName: String {
        switch self {
        case .morgana: return "Morgana"
        case .rasputin: return "Rasputin"
        }
    }

    var imageAssets: (head: String, torso: String, frontArm: String, backArm: String, foot: String, backFoot: String?) {
        switch self {
        case .morgana:
            return (
                head: "head",
                torso: "torso",
                frontArm: "frontArm",
                backArm: "backArm",
                foot: "foot",
                backFoot: "backFoot"
            )
        case .rasputin:
            return (
                head: "headRasputin",
                torso: "torsoRasputin",
                frontArm: "frontArmRasputin",
                backArm: "backArmRasputin",
                foot: "footRasputin",
                backFoot: "backFootRasputin"
            )
        }
    }
}
