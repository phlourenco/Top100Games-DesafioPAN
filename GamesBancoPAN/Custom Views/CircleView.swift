//
//  CircleView.swift
//  GamesBancoPAN
//
//  Created by Paulo Lourenço on 24/01/18.
//

import UIKit

class CircleView: UIView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.layer.cornerRadius = self.bounds.height / 2
    }
    
}
