//
//  Colors.swift
//  RxFood
//
//  Created by Hira on 12/7/18.
//  Copyright © 2018 Mac. All rights reserved.
//

import UIKit

enum Colors {
    case Primary
    case Accent
    case Background
}

extension Colors {
    var value: UIColor {
        var instanceColor = UIColor.clear

        switch self {
        case .Primary:
            instanceColor = UIColor.rgb(red: 231, green: 76, blue: 61)

        case .Accent:
            instanceColor = UIColor.rgb(red: 35, green: 181, blue: 116)

        case .Background:
            instanceColor = UIColor.rgb(red: 250, green: 250, blue: 250)
        }

        return instanceColor
    }
}
