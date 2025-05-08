//
//  IngredientController.swift
//  babayaga
//
//  Created by user on 28/04/25.
//

import Foundation
import UIKit

class IngredientController {
    let model: Ingredient
    let view: IngredientView
    var stack: [Ingredient] = []
    
    var count: Int {
        return stack.count
    }

    init(model: Ingredient) {
        self.model = model
        self.view = IngredientView(model: model)
    }
    
    func push(_ ingredient: Ingredient) {
        stack.append(ingredient)
        print("Empilhou: \(ingredient.name)")
    }
    
    func pop() -> Ingredient? {
        return stack.popLast()
    }
    
    func clear() {
        stack.removeAll()
    }
    
    func currentStack() -> [Ingredient] {
        return stack
    }
    
    func collect() {
        view.removeFromParent()
        print("Ingrediente coletado: \(model.name)")
    }
    
}
