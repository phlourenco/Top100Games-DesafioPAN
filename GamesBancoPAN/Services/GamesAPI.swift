//
//  GamesAPI.swift
//  GamesBancoPAN
//
//  Created by Paulo Lourenço on 23/01/18.
//

import Alamofire
import SwiftyJSON

class GamesAPI {
    
    let gamesURL = "\(APIManager.mainUrl)/games"

    enum endpoints: String {
        case top = "/top"
    }
    
    func getTop(limit: Int, offset: Int, completed: @escaping RequestResponse) {
        
        let url = "\(gamesURL)/\(endpoints.top)?limit=\(limit)&offset=\(offset)"
        print(url)
        
        Alamofire.request(url, method: .get, encoding: JSONEncoding.default).responseJSON { (response) in
            
            print(response.result)
        
            if let value = response.result.value {
                let json = JSON(value)
                print(json)
                if let _ = json["error"].string {
                    completed(nil)
                    return
                }
                completed(GameList(json: json))
            } else {
                completed(nil)
            }
        }
        
    }
    
}
