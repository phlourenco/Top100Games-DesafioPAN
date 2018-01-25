//
//  Utils.swift
//  GamesBancoPAN
//
//  Created by Paulo Lourenço on 24/01/18.
//

import Foundation
import Alamofire

class Utils {    
    class func isConnected() -> Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}
