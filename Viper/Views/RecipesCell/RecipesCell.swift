//
//  RecipesCell.swift
//  Viper
//
//  Created by Ilya Slipak on 10/4/19.
//  Copyright © 2019 Ilya Slipak. All rights reserved.
//

import UIKit
import Kingfisher

final class RecipesCell: UITableViewCell {

    @IBOutlet weak var recipesImageView: UIImageView!
    @IBOutlet weak var recipesTitle: UILabel!
    @IBOutlet weak var recipesDescription: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        recipesImageView.circleCornerRadius(height: recipesImageView.frame.height, widht: recipesImageView.frame.width)
        recipesImageView.layer.borderWidth = 0.77
        recipesImageView.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    func configure(recipesModel: Recipe) {
        
        
        recipesTitle.text = recipesModel.title ?? "Empty title"
        recipesDescription.text = recipesModel.ingredients
        setupImageView(stringUrl: recipesModel.thumbnail)
    }
    
    private func setupImageView(stringUrl: String?) {
        
        guard let stringUrl = stringUrl else {
            recipesImageView.image = R.image.noImageIcon()!
            return
        }
        
        recipesImageView.kf.setImage(with: URL(string: stringUrl))
    }
}
