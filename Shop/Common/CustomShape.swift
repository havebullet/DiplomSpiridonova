//
//  CustomShape.swift
//  Shop
//
//  Created by Настя on 15.04.2022.
//

import Foundation
import SwiftUI

struct CustomShape: Shape {
    
    let corners: UIRectCorner
    let size: Int
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: size, height: size))
        return Path(path.cgPath)
    }
}
