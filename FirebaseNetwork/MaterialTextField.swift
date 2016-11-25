//
//  MaterialTextField.swift
//  FirebaseNetwork
//
//  Created by Lucheo Antonio Tombini Filho on 24/11/16.
//  Copyright © 2016 Lucheo Antonio Tombini Filho. All rights reserved.
//

import UIKit

class MaterialTextField: UITextField {

    override func awakeFromNib() {
        layer.cornerRadius = 15.0
        layer.borderColor = UIColor(red: ShadowCOLOR, green: ShadowCOLOR, blue: ShadowCOLOR, alpha: 0.3).cgColor
        layer.borderWidth = 2.0

    }
    
    //placeholder
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 10.0, dy: 0.0)
        
    }
    //textholder
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 10.0, dy: 0.0)
    }

}
