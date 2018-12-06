//
//  Color+Ext.swift
//  RxFood
//
//  Created by Sujal on 12/6/18.
//  Copyright © 2018 Mac. All rights reserved.
//

import UIKit

extension UIColor {
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor.init(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
}
