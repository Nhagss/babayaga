//
//  Router.swift
//  babayaga
//
//  Created by Joao Roberto Fernandes Magalhaes on 02/05/25.
//

import Foundation
import SwiftUI

class Router: ObservableObject {
    @Published var path = NavigationPath()

    func goToGameScene() {
        path.append(Views.GameViewController.self)
    }
    
    func goToInitialScreen(){
        path.append(Views.InitialScreen.self)
    }
}
