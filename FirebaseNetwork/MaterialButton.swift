//
//  MaterialButton.swift
//  FirebaseNetwork
//
//  Created by Lucheo Antonio Tombini Filho on 24/11/16.
//  Copyright © 2016 Lucheo Antonio Tombini Filho. All rights reserved.
//

import UIKit

class MaterialButton: UIButton {

    override func awakeFromNib() {
        layer.cornerRadius = 8.0
        layer.shadowColor = UIColor(red: ShadowCOLOR, green: ShadowCOLOR, blue: ShadowCOLOR, alpha: 0.5).cgColor
        layer.shadowOpacity = 0.8
        layer.shadowRadius = 5.0
        layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        
    }
}
