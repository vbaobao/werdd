//
//  WordListTableView.swift
//  werdd
//
//  Created by Virginia Bao on 10/16/22.
//

import Foundation
import UIKit

class WordListTableView: UITableView {
    
    init() {
        super.init(frame: .zero, style: .plain)
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Set up UI
    
    private func setUpUI() {
        translatesAutoresizingMaskIntoConstraints = false
        showsVerticalScrollIndicator = false
        backgroundColor = .clear
        separatorColor = .clear
        layer.cornerRadius = Padding.rounding.rawValue
        layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
}

extension WordListTableView: WordListDelegate {
    func update(highlightedWord newWord: WordData?) {
        self.reloadSections(IndexSet(integer: 0), with: .fade)
    }
}
