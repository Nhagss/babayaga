//
//  PhysicsCategory.swift
//  babayaga
//
//  Created by user on 23/04/25.
//

import Foundation

struct PhysicsCategory {
    static let player: UInt32 = 0x1 << 0
    static let obstacle: UInt32 = 0x1 << 1
    static let planet: UInt32 = 0x1 << 2
    static let stair: UInt32 = 0x1 << 3
    static let ingredient: UInt32 = 0x1 << 4
    static let none: UInt32 = 0
}
