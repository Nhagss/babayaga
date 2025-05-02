//
//  IngredientController.swift
//  babayaga
//
//  Created by user on 28/04/25.
//

import Foundation

class IngredientController {
    let model: Ingredient
    let view: IngredientView

    init(model: Ingredient) {
        self.model = model
        self.view = IngredientView(model: model)
    }
}
