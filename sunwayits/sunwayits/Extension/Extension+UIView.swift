//
//  Extension+UIView.swift
//  sunwayits
//
//  Created by Paul Wen on 2024/12/31.
//

import UIKit

extension UIView{
    func anchor(top: NSLayoutYAxisAnchor?,left: NSLayoutXAxisAnchor?,bottom: NSLayoutYAxisAnchor?,right: NSLayoutXAxisAnchor?,paddingTop: CGFloat,paddingLeft:CGFloat,paddingBottom:CGFloat,paddingRight:CGFloat,width:CGFloat,height:CGFloat){
        translatesAutoresizingMaskIntoConstraints = false
        if let top = top{
            self.topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }
        if let left = left{
            self.leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
        }
        if let bottom = bottom{
            self.bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
        }
        if let right = right{
            self.rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
        }
        if width != 0{
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        if height != 0{
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
}

extension UIView{
    func setShadow(){
//        self.layer.shadowOffset = CGSize(width: 0, height: 3)
//        self.layer.shadowOpacity = 3
//        self.layer.shadowRadius = 7
//        self.layer.shadowColor = UIColor.shadowColor().cgColor
//        self.layer.shadowColor = UIColor.greyText().cgColor
        self.layer.shadowOpacity = 1
        self.layer.shadowOffset = .zero
        self.layer.shadowRadius = 10
    }
}
