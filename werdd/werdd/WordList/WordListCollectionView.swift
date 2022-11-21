//
//  WordListCollectionView.swift
//  werdd
//
//  Created by Virginia Bao on 11/21/22.
//

import Foundation
import UIKit

class WordListCollectionView: UICollectionViewCell {
    
    init() {
        super.init(frame: .zero)
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Set up UI
    
    private func setUpUI() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .clear
        layer.cornerRadius = Padding.rounding.rawValue
        layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
}
