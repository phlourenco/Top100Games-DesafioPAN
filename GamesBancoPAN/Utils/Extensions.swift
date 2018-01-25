//
//  Extensions.swift
//  GamesBancoPAN
//
//  Created by Paulo Lourenço on 24/01/18.
//

import Foundation
import UIKit

extension UIViewController {
    
    //Makes easier to show alerts
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}
