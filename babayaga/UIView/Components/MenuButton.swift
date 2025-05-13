//
//  MenuButton.swift
//  babayaga
//
//  Created by Joao Roberto Fernandes Magalhaes on 13/05/25.
//

import Foundation
import SwiftUI

struct MenuButton: Identifiable {
    let id = UUID()
    let label: String
    let icon: String?
    let destination: Views
}

