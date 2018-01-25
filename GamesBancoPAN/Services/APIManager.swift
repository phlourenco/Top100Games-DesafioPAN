//
//  APIManager.swift
//  GamesBancoPAN
//
//  Created by Paulo Lourenço on 23/01/18.
//

import Foundation
import Alamofire

typealias RequestResponse = (_ data: Any?) -> ()

class APIManager {
    static let shared = APIManager()
    
    static let mainUrl = "https://api.twitch.tv/kraken"
    static let clientId = "rew23czzdgrosibji7tp5kw8idyc4v" //Twitch Client ID
    
    var games = GamesAPI()
    
    init(){
        Alamofire.SessionManager.default.adapter = TwitchHeadersAdapter()
    }
}

class TwitchHeadersAdapter: RequestAdapter {
    
    func adapt(_ urlRequest: URLRequest) throws -> URLRequest {
        var urlRequest = urlRequest
        
        //Adds custom required headers according to Twitch API documentation:
        //https://dev.twitch.tv/docs/v5/reference/games
        urlRequest.setValue("application/vnd.twitchtv.v5+json", forHTTPHeaderField: "Accept")
        urlRequest.setValue(APIManager.clientId, forHTTPHeaderField: "Client-ID")
        
        return urlRequest
    }
    
}
