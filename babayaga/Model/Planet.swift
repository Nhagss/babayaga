//
//  PlanetModel.swift
//  babayaga
//
//  Created by user on 25/04/25.
//

import Foundation

class Planet {
    
    var isContactingStair: Bool = false
    var rotationSpeed: CGFloat = 3
    var direction: CGFloat { rotationSpeed > 0 ? 1 : -1 }

    func reverseDirection() {
        rotationSpeed *= -1
    }

    func slowedSpeed() -> CGFloat {
        return 1 * direction
    }

    func regularSpeed() -> CGFloat {
        return 3 * direction
    }
}
