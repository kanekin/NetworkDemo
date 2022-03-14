//
//  Color+Extension.swift
//  NetworkDemo
//
//  Created by Tatsuya Kaneko on 14/03/2022.
//

import Foundation
import SwiftUI

extension Color {
    static let label = Color(UIColor.label)
    static let secondaryLabel = Color(UIColor.secondaryLabel)
    static let tertiaryLabel = Color(UIColor.tertiaryLabel)
    static let quaternaryLabel = Color(UIColor.quaternaryLabel)
    
    static let systemGray = Color(UIColor.systemGray)
    static let systemGray2 = Color(UIColor.systemGray2)
    static let systemGray3 = Color(UIColor.systemGray3)
    static let systemGray4 = Color(UIColor.systemGray4)
    static let systemGray5 = Color(UIColor.systemGray5)
    static let systemGray6 = Color(UIColor.systemGray6)
    
    
    static let background = Color(UIColor.systemBackground)
    static let secondaryBackground = Color(UIColor.secondarySystemBackground)
    static let tertiaryBackground = Color(UIColor.tertiarySystemBackground)
    
    
    static var gradient: Array<Color> {
        return [
            black.opacity(0.0),
            black.opacity(0.2),
            black.opacity(0.5),
            black.opacity(1.0),
        ]
    }
}
