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

    @IBOutlet weak var heartButton: UIButton! {
        didSet {
            heartButton.imageView?.image = #imageLiteral(resourceName: "heart_unselected").withRenderingMode(.alwaysTemplate)
            heartButton.tintColor = .white
        }
    }
    var food: Food? {
        didSet {
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
