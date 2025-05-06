//
//  SettingsView.swift
//  babayaga
//
//  Created by Joao Roberto Fernandes Magalhaes on 05/05/25.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        NavigationStack {
            ZStack {
    
                Background()
                    .blur(radius: 5)
                
                VStack (spacing: 100){
                    HStack(spacing: 40) {
                        
                        ButtonComponent()
                            .padding(.bottom, 110)
                        
                        
                        ButtonComponent()
                        
                        ButtonComponent()
                            .padding(.bottom, 100)
                    }
                    
                    HStack(spacing: 40) {
                        
                        ButtonComponent()
                            .padding(.bottom, 110)
                        
                        ButtonComponent()
                        
                        ButtonComponent()
                            .padding(.bottom, 100)
                    }
                }
            }
        }
    }
}

#Preview {
    SettingsView()
}
