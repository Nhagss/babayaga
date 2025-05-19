//
//  Character.swift
//  babayaga
//
//  Created by Joao Roberto Fernandes Magalhaes on 16/05/25.
//

import Foundation
import SpriteKit

@Observable
class Character {
    let id: Int
    let name: String
    
    init(id: Int, name: String, total: Int) {
        self.id = id
        self.name = name
    }
}
