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
    var onCollect: () -> Void
    
    var count: Int {
        return stack.count
    }

    init(model: Ingredient, onCollect: @escaping () -> Void) {
        self.model = model
        self.view = IngredientView(model: model)
        self.onCollect = onCollect
    }
    
    func push(_ ingredient: Ingredient) {
        stack.append(ingredient)
//        print("Empilhou: \(ingredient.name)")
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
        if model.remaining > 0 {
            model.remaining -= 1
            view.removeFromParent()
            self.onCollect()
//            print("Ingrediente coletado: \(model.name) - Restantes: \(model.remaining)")
        }
    }
    
    func isCollected() -> Bool {
        return model.remaining <= 0
    }
    
}
