//
//  UICollectionViewExtension.swift
//  GHinnotec
//
//  Created by Gursewak Singh on 06/12/24.
//

import Foundation
import UIKit

extension UICollectionView {
    
    func reloadData(completion: @escaping ()->()) {
        UIView.animate(withDuration: 0, animations: { self.reloadData() })
        { _ in completion() }
    }
}
