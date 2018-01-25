//
//  GameCell.swift
//  GamesBancoPAN
//
//  Created by Paulo Lourenço on 23/01/18.
//

import UIKit
import SDWebImage
import CoreData

class GameCell: UICollectionViewCell {
    
    //coredata
    var appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var activityView: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
//    override func prepareForReuse() {
//        super.prepareForReuse()
//        //prevent image to repeat and
//        imgView.image = nil
//    }
    
    func configureCell(game: GameModel) {
//        game.delegate = self
        imgView.image = nil
        if game.game == nil, let img = game.details.box.medium {
            imgView.sd_setImage(with: URL(string: img), completed: { (image, error, cacheType, url) in
                self.activityView.isHidden = true
            })
        } else if let gamecd = game.game, let mediumImage = gamecd.mediumImage {
            imgView.image = UIImage(data: mediumImage as Data)
        }
        titleLbl.text = game.details.name
    }
    
}

//extension GameCell: ImageLoadDelegate {
//    
//    func loadedImage(type: ImageType, image: UIImage) {
//        print("loadedImage")
//        imgView.image = image
//    }
//    
//}






