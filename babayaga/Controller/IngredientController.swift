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
    var onCollect: () -> Void

    init(model: Ingredient, onCollect: @escaping () -> Void) {
        self.model = model
        self.view = IngredientView(model: model)
        self.onCollect = onCollect
    }
    
    func collect() {
        if model.remaining > 0 {
            model.remaining -= 1
            view.removeFromParent()
            self.onCollect()
        }
    }
}
