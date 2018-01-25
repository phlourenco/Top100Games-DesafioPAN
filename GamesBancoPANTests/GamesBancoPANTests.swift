//
//  GamesBancoPANTests.swift
//  GamesBancoPANTests
//
//  Created by Paulo Lourenço on 23/01/18.
//

import XCTest
@testable import GamesBancoPAN

class GamesBancoPANTests: XCTestCase {
    
    let gamesViewModel = GamesViewModel()
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testLimit() {
        let limit = 10
        gamesViewModel.getTop(limit: limit, offset: 0) { (isOk) in
            if isOk {
                XCTAssert(self.gamesViewModel.topGames.count == limit, "Limit is not working")
            }
        }
    }
    
    func testDetails() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        XCTAssertNotNil(storyboard, "Storyboard error")
        
        guard let vc = storyboard.instantiateViewController(withIdentifier: "DetailsVC") as? DetailsVC else {
            XCTAssert(false, "Can't instantiate DetailsVC")
            return
        }
        
        _ = vc.view
        
        let testGame = GameModel(name: "Test Game", viewers: 10, channels: 100)
        vc.bindUI(testGame)
        
        XCTAssert(vc.titleLbl.text == testGame.details.name, "Details UI binding fail")
    }
    
}
