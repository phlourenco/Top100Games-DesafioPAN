//
//  GameModels.swift
//  GamesBancoPAN
//
//  Created by Paulo Lourenço on 23/01/18.
//

import Foundation
import SwiftyJSON

struct GameModel {
    var details: GameDetails! //propertie "game" in response's json
    var viewers: Int = 0
    var channels: Int = 0
    
    var game: Game? //coredata model
        
    init() {}
    
    init(name: String, viewers: Int, channels: Int) {
        var details = GameDetails()
        details.name = name
        
        self.details = details
        self.viewers = viewers
        self.channels = channels
    }
    
    init(json: JSON) {
        if let _ = json["game"].dictionary {
            self.details = GameDetails(json: json["game"])
        }
        
        if let viewers = json["viewers"].int {
            self.viewers = viewers
        }
        
        if let channels = json["channels"].int {
            self.channels = channels
        }
    }
    
    //Creates according to CoreData model
    init(game: Game) {
        self.game = game
        
        var gameDetails = GameDetails()
        gameDetails.name = game.name
        gameDetails.box = ImageList()
        
        self.details = gameDetails
        self.viewers = Int(game.viewers)
        self.channels = Int(game.channels)
    }
}

struct GameDetails {
    var name: String!
    var box: ImageList!
    
    init() {}
    
    init(json: JSON) {
        
        if let name = json["name"].string {
            self.name = name
        }
        
        if let _ = json["box"].dictionary {
            self.box = ImageList(json: json["box"])
        }
    }
}

struct ImageList {
    var large: String?
    var medium: String?
    
    init() {}
    
    init(json: JSON) {
        if let large = json["large"].string {
            self.large = large
        }
        
        if let medium = json["medium"].string {
            self.medium = medium
        }
    }
}
