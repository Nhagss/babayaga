//
//  Router.swift
//  babayaga
//
//  Created by Joao Roberto Fernandes Magalhaes on 02/05/25.
//

import Foundation
import SwiftUI

class Router: ObservableObject {
    static var shared: Router = Router()
    
    @Published var path = NavigationPath()
    
    func goToGameScene() {
        path.append(Views.GameViewController.self)
    }
    func goToInitialScreen(){
        path.append(Views.InitialScreen.self)
    }
        
    func goToLevelsView() {
        path.append(Views.LevelsView.self)
    }
    
    func goBack() {
        path.removeLast()
    }
    
    func goToRoot() {
        path.removeLast(path.count)
    }
    
    func backToMenu() {
        path = .init()
    }
    
    func goToSettingsView() {
        path.append(Views.SettingsView.self)
    }
    func goToChooseCharacter() {
        path.append(Views.ChooseCharacter.self)
    }
}
