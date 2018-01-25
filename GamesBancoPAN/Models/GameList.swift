//
//  GameList.swift
//  GamesBancoPAN
//
//  Created by Paulo Lourenço on 23/01/18.
//

import Foundation
import SwiftyJSON

struct GameList {
    var _total: Int!
    var _links: LinkList!
    var top: [GameModel] = []
    
    init(json: JSON) {
        if let total = json["_total"].int {
            self._total = total
        }
        
        if let _ = json["_links"].dictionary {
            self._links = LinkList(json: json["_links"])
        }
        
        if let tops = json["top"].array {
            self.top = tops.map { GameModel(json: $0) }
        }
    }
}

struct LinkList {
    var _self: String!
    var next: String!
    
    init(json: JSON) {
        if let _self = json["self"].string {
            self._self = _self
        }
        
        if let next = json["next"].string {
            self.next = next
        }
    }
}
