//
//  UITextfieldExtension.swift
//  GHinnotec
//
//  Created by Gursewak Singh on 07/12/24.
//

import Foundation
import UIKit

extension UITextField {
    func addBottomBorder(){
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0, y: self.frame.size.height - 1, width: self.frame.size.width, height: 1)
        bottomLine.backgroundColor = UIColor(hexString: "#D9D9D9").cgColor
        borderStyle = .none
        layer.addSublayer(bottomLine)
    }
}
