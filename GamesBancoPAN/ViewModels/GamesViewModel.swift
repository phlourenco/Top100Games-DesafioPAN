//
//  GamesViewModel.swift
//  GamesBancoPAN
//
//  Created by Paulo Lourenço on 23/01/18.
//

import Foundation
import CoreData
import UIKit
import SDWebImage
import Alamofire

class GamesViewModel {
    
    //coredata
    var appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    //vars
    var topGames = [GameModel]()
    var allSavedGames = [Game]()
    
    func getTop(limit: Int = 10, offset: Int = 0, completed: @escaping (_ isOk: Bool) -> ()) {
        
        APIManager.shared.games.getTop(limit: limit, offset: offset) { (data) in
            guard let gameList = data as? GameList else {
                print("getTop error!")
                completed(false)
                return
            }
            
            if offset == 0 {
                print("First page - cleaning list...")
                self.topGames = [] //if it's first page, clear list
                self.deleteAllRecords()
            }
            
            for item in gameList.top {
                self.topGames.append(item)
                self.saveGame(item) //saves in CoreData
            }
            
            completed(true)
        }
    }
    
    func getTopSaved(limit: Int = 10, offset: Int = 0,  completed: @escaping (_ isOk: Bool, _ count: Int) -> ()) {
        
        print("getTopSaved: limit=\(limit) offset=\(offset)")
        
        if offset == 0 {
            print("getTopSaved first page = fetching all saved data...")
            topGames = []
            
            do {
                allSavedGames = try context.fetch(Game.fetchRequest())
            } catch {
                print("getTopSaved error: \(error.localizedDescription)")
                completed(false, 0)
                return
            }
        }
        
        guard allSavedGames.count >= offset+limit else {
            print("ops!!")
            completed(false, 0)
            return
        }
        
        let temp10games = allSavedGames[offset..<offset+limit]
        
        for item in temp10games {
            self.topGames.append(GameModel(game: item))
        }
        
        completed(true, self.topGames.count)
    }
    
    func saveGame(_ game: GameModel) {
        print("Saving \(game.details.name) to CoreData")
        
        let tempGame = Game(entity: Game.entity(), insertInto: self.context)
        tempGame.name = game.details.name
        tempGame.viewers = Int32(game.viewers)
        tempGame.channels = Int32(game.channels)
        self.appDelegate.saveContext()
        
        let tempImgView = UIImageView(image: nil)
        guard let mediumImg = game.details.box.medium, let largeImg = game.details.box.large else {
            return
        }
        
        Alamofire.request(mediumImg).responseData { (response) in
            if let data = response.data {
                tempGame.mediumImage = data as NSData
                self.appDelegate.saveContext()
            }
        }
        
        Alamofire.request(largeImg).responseData { (response) in
            if let data = response.data {
                tempGame.largeImage = data as NSData
                self.appDelegate.saveContext()
            }
        }
    }
    
    func deleteAllRecords() {
        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Game")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
        
        do {
            try context.execute(deleteRequest)
            try context.save()
        } catch {
            print ("There was an error")
        }
    }

    
}











