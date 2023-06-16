//
//  DogsView.swift
//  TestTS4
//
//  Created by cesar.torres on 14/06/23.
//
//

import UIKit

class DogCell: UITableViewCell {
    
    @IBOutlet weak var imageDog: ImageLoader!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblAge: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configureDog(entity: DogsResponse?) {
        if let urlImage = entity?.image {
            imageDog.downloadImageFrom(url: urlImage, imageMode: .scaleAspectFill)
        }
        lblName.text = entity?.name
        lblDescription.text = entity?.description
        lblAge.text = "LifeSpan " + (entity?.lifeSpan ?? "")
    }
}
