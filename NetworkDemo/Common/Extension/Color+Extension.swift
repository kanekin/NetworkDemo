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
    
    
    static let systemBackground = Color(UIColor.systemBackground)
    static let secondarySystemBackground = Color(UIColor.secondarySystemBackground)
    static let tertiarySystemBackground = Color(UIColor.tertiarySystemBackground)
    
    
    static var gradient: Array<Color> {
        return [
            black.opacity(0.0),
            black.opacity(0.2),
            black.opacity(0.5),
            black.opacity(1.0),
        ]
    }
    
    static var gradientFromCenter: Array<Color> {
        return [
            black.opacity(0.0),
            black.opacity(0.2),
            black.opacity(0.5),
            black.opacity(0.7),
            black.opacity(0.5),
            black.opacity(0.2),
            black.opacity(0.0),
        ]
    }
    
    static var backgroundGradient: Array<Color> {
        return [
            Color(uiColor: .systemBackground).opacity(0.0),
            Color(uiColor: .systemBackground).opacity(0.2),
            Color(uiColor: .systemBackground).opacity(0.5),
            Color(uiColor: .systemBackground).opacity(1.0),
        ]
    }
}
