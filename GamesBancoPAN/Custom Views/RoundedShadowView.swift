//
//  RoundedShadowView.swift
//  GamesBancoPAN
//
//  Created by Paulo Lourenço on 23/01/18.
//

import UIKit

@IBDesignable class RoundedShadowView: UIView {
    
    var shadowAdded: Bool = false
    
    override func draw(_ rect: CGRect) {
        if shadowAdded { return }
        shadowAdded = true
        
        let shadowLayer = UIView(frame: self.frame)
        shadowLayer.backgroundColor = UIColor.clear
        shadowLayer.layer.shadowColor = UIColor.darkGray.cgColor
        shadowLayer.layer.shadowPath = UIBezierPath(roundedRect: bounds.insetBy(dx: 0.0, dy: 0.0), cornerRadius: 3).cgPath
        shadowLayer.layer.shadowOffset = CGSize.zero
        shadowLayer.layer.shadowOpacity = 0.3
        shadowLayer.layer.shadowRadius = 4.0
        shadowLayer.layer.masksToBounds = true
        shadowLayer.clipsToBounds = false
        
        self.superview?.addSubview(shadowLayer)
        self.superview?.bringSubview(toFront: self)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.layer.cornerRadius = 5.0
        self.layer.masksToBounds = true
    }
    
}
