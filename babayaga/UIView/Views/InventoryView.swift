//
//  InventoryView.swift
//  babayaga
//
//  Created by honorio on 08/05/25.
//

import SwiftUI

struct InventoryView: View {
    var ingredients: [Ingredient]
    
    var body: some View {
        Capsule()
            .strokeBorder(.white,lineWidth: 2)
            .background(.black)
            .clipShape(Capsule())
            .frame(maxHeight: 50)
            .frame(width: 100)
            .vSpacing(.top)
            .hSpacing(.trailing)
            .border(.black)
    }
}

#Preview {
    InventoryView(ingredients: [
        Ingredient(id: 1, name: "Pó de fada", total: 3),
        Ingredient(id: 2, name: "Suor de goblin", total: 2),
        Ingredient(id: 3, name: "Pena de corvo", total: 1),
        Ingredient(id: 4, name: "Água da lua cheia", total: 4)
    ])
}
