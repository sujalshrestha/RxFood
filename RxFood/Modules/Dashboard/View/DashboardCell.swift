//
//  DashboardCell.swift
//  RxFood
//
//  Created by Hira on 12/7/18.
//  Copyright © 2018 Mac. All rights reserved.
//

import UIKit
import SDWebImage

class DashboardCell: UICollectionViewCell {
    @IBOutlet weak var foodImage: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var details: UILabel!

    var food: Food? {
        didSet {
            //backgroundColor = Colors.Background.value
            foodImage.sd_setImage(with: URL(string: food?.imageURL ?? ""))
            title.text = food?.title ?? ""
            details.text = food?.description ?? ""
        }
    }

    override func awakeFromNib() {
        layer.cornerRadius = 8
        layer.masksToBounds = true
    }

}
