//
//  RoundBtn.swift
//  FirebaseNetwork
//
//  Created by Lucheo Antonio Tombini Filho on 09/01/17.
//  Copyright © 2017 Lucheo Antonio Tombini Filho. All rights reserved.
//

import UIKit

class RoundBtn: UIButton {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.shadowColor = UIColor(red: ShadowCOLOR, green: ShadowCOLOR, blue: ShadowCOLOR, alpha: 0.6).cgColor
        layer.shadowOpacity = 0.8
        layer.shadowRadius = 5.0
        layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        imageView?.contentMode = .scaleAspectFit
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.cornerRadius = self.frame.width / 2
    }



}
