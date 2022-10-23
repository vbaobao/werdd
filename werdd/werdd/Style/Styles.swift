//
//  Colors.swift
//  werdd
//
//  Created by Virginia Bao on 10/4/22.
//

import Foundation
import UIKit

enum Padding: CGFloat {
    case xsmall = 8
    case small = 12
    case medium = 16
    case large = 24
    case rounding = 18
    
    static func size(_ padding: Padding) -> CGFloat {
        padding.rawValue
    }
}

struct Styles {
    enum Colors {
        case background
        case primary
        case secondary
        case accent
        case white
    }

    enum Text {
        case standard
        case alert
        case faint
    }

    enum FontStyle: String {
        case standard = "Lato-Regular"
        case standard_italic = "Lato-Italic"
        case bold = "Lato-Bold"
        case bold_italic = "Lato-BoldItalic"
        case light = "Lato-Light"
        case light_italic = "Lato-LightItalic"
        case thick = "Lato-Black"
        case thick_italic = "Lato-BlackItalic"
    }

    enum FontSize: CGFloat {
        case xlarge = 34
        case large = 28
        case standard = 16
        case small = 13
    }
    
    static func background(_ color: Colors) -> UIColor {
        switch color {
        case .background:
            return UIColor(red: 250/255, green: 243/255, blue: 243/255, alpha: 1)
        case .primary:
            return UIColor(red: 167/255, green: 187/255, blue: 199/255, alpha: 1)
        case .secondary:
            return UIColor(red: 225/255, green: 229/255, blue: 234/255, alpha: 1)
        case .accent:
            return UIColor(red: 218/255, green: 127/255, blue: 143/255, alpha: 1)
        case .white:
            return UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        }
    }
    
    static func text(_ color: Text) -> UIColor {
        switch color {
        case .standard:
            return UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        case .alert:
            return UIColor(red: 218/255, green: 127/255, blue: 143/255, alpha: 1)
        case .faint:
            return UIColor(red: 65/255, green: 63/255, blue: 66/255, alpha: 1)
        }
    }
    
    static func font(size: FontSize, style: FontStyle) -> UIFont? {
        UIFont(name: style.rawValue, size: size.rawValue)
    }
}

struct Image {
    enum System: String, CustomStringConvertible {
        case refresh = "arrow.clockwise.circle"
        
        var description: String {
            self.rawValue
        }
    }
    
    enum Size {
        case small
        case medium
        case large
        
        var config: UIImage.Configuration {
            switch self {
            case .small:
                return UIImage.SymbolConfiguration(pointSize: 24, weight: .regular, scale: .default)
            case .medium:
                return UIImage.SymbolConfiguration(pointSize: 36, weight: .regular, scale: .default)
            case .large:
                return UIImage.SymbolConfiguration(pointSize: 48, weight: .regular, scale: .default)
            }
        }
    }
    
    static func image(symbol assetName: System, size: Size) -> UIImage? {
        switch assetName {
        case .refresh:
            return UIImage(systemName: String(assetName.description), withConfiguration: size.config)
        }
    }
}
