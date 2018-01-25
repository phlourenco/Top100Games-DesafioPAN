//
//  DetailsVC.swift
//  GamesBancoPAN
//
//  Created by Paulo Lourenço on 24/01/18.
//

import UIKit

class DetailsVC: UIViewController {
    
    //outlets
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var channelsLbl: UILabel!
    @IBOutlet weak var viewsLbl: UILabel!
    //vars
    var game: GameModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        bindUI(game)
    }
    
    func bindUI(_ game: GameModel) {
        print("\(game.details)")
        if game.game == nil, let imgBox = game.details.box, let img = imgBox.large {
            //Load image from link
            imgView.sd_setImage(with: URL(string: img))
        } else if let gamecd = game.game, let largeImage = gamecd.largeImage {
            //Load image from CoreData
            imgView.image = UIImage(data: largeImage as Data)
        }
        titleLbl.text = game.details.name
        channelsLbl.text = "\(game.channels) \((game.channels == 1 ? "Canal" : "Canais"))"
        viewsLbl.text = "\(game.viewers) \((game.viewers == 1 ? "Visualização" : "Visualizações"))"
    }
    
    @IBAction func closeAct(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
