//
//  UIViewExtension.swift
//  GHinnotec
//
//  Created by Gursewak Singh on 06/12/24.
//

import Foundation
import UIKit

extension UIView {

    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }

    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }

    @IBInspectable
    var borderColor: UIColor? {
        get {
            let color = UIColor.init(cgColor: layer.borderColor!)
            return color
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }

    @IBInspectable
    var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {

            layer.shadowRadius = newValue
        }
    }
    @IBInspectable
    var shadowOffset : CGSize{

        get{
            return layer.shadowOffset
        }set{

            layer.shadowOffset = newValue
        }
    }

    @IBInspectable
    var shadowColor : UIColor{
        get{
            return UIColor.init(cgColor: layer.shadowColor!)
        }
        set {
            layer.shadowColor = newValue.cgColor
        }
    }
    @IBInspectable
    var shadowOpacity : Float {

        get{
            return layer.shadowOpacity
        }
        set {

            layer.shadowOpacity = newValue

        }
    }
}
extension UIButton {
//    func setImageTintColor(_ color: UIColor) {
//        let tintedImage = self.imageView?.image?.withRenderingMode(.alwaysTemplate)
//        
//        if state == .normal{
//            self.setImage(tintedImage, for: .normal)
//        }else{
//            self.setImage(tintedImage, for: .selected)
//        }
//        self.tintColor = color
//    }
//    
    func setImageTintColor(_ color: UIColor, for state: UIControl.State = .normal) {
            guard let originalImage = self.image(for: state) else { return }
            let tintedImage = originalImage.withRenderingMode(.alwaysTemplate)
            self.setImage(tintedImage, for: state)
            self.tintColor = color
        }
}
