//
//  Extension+UIColor.swift
//  sunwayits
//
//  Created by Paul Wen on 2024/12/31.
//

import UIKit

extension UIColor{
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor{
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
    static func softPink() -> UIColor{ return rgb(red: 249, green: 178, blue: 220)}
    static func hotPink() -> UIColor{ return rgb(red: 236, green: 0, blue: 140)}
    static func lightGrey() -> UIColor{ return rgb(red: 153, green: 153, blue: 153)}
    static func textColor() -> UIColor{ return rgb(red: 71, green: 71, blue: 71)}
    static func frogGreen() -> UIColor{ return rgb(red: 86, green: 179, blue: 11)}
    static func booger() -> UIColor{ return rgb(red: 166, green: 204, blue: 66)}
    static func backgroundColor() -> UIColor{ return rgb(red: 252, green: 252, blue: 252)}
    static func bottomLineColor() -> UIColor{ return rgb(red: 228, green: 228, blue: 228)}
}
