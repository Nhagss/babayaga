//
//  PilhaDoNeto.swift
//  POC_game
//
//  Created by Joao Roberto Fernandes Magalhaes on 15/04/25.
//

import Foundation
import SpriteKit

struct PilhaDeIngredientes {
    private var pilha: [Ingredient] = []

    mutating func empilhar(_ ingrediente: Ingredient) {
        pilha.append(ingrediente)
        //print("Empilhou: \(ingrediente.nome)")
    }

    func verificarSeCorreta(com ordem: [Int]) -> Bool {
        let ids = pilha.map { $0.id }
        return ids == ordem
    }

    func mostrarPilha() {
        print("Pilha atual:")
        for ingrediente in pilha.reversed() {
            print("\(ingrediente.nome)")
        }
    }

    var quantidade: Int {
        return pilha.count
    }
}
