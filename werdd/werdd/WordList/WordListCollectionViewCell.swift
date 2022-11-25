//
//  WordListCollectionViewCell.swift
//  werdd
//
//  Created by Virginia Bao on 11/21/22.
//

import Foundation
import UIKit

class WordListCollectionViewCell: UICollectionViewCell {
    
    var wordCard: WordCardViewCell
    
    init() {
        self.wordCard = WordCardViewCell(with: nil)
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        setUpUI()
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Set up UI
    
    private func setUpUI() {
        backgroundColor = .clear
        contentView.backgroundColor = Styles.background(.secondary)
        contentView.layer.cornerRadius = Padding.size(.rounding)
        wordCard.definition.lineBreakMode = .byTruncatingTail
        
        wordCard.setWord(font: Styles.font(size: .standard, style: .bold),
                         color: Styles.textColor(.standard))
        wordCard.setPartOfSpeech(font: Styles.font(size: .small, style: .light_italic),
                                 color: Styles.textColor(.standard))
        wordCard.setDefinition(font: Styles.font(size: .small, style: .light),
                               color: Styles.textColor(.standard))
        
        contentView.addSubview(wordCard)
    }
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            wordCard.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            wordCard.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor),
            wordCard.topAnchor.constraint(equalTo: contentView.topAnchor),
            wordCard.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
    
    // MARK: - Helper function
    
    func update(with word: String?, data: WordData?) {
        wordCard.updateCell(with: word, data: data)
    }
    
    func didSelect() {
        UIView.animate(withDuration: 0.4) {
            self.contentView.backgroundColor = Styles.background(.primary)
        }
    }
    
    func didDeselect() {
        UIView.animate(withDuration: 0.4) {
            self.contentView.backgroundColor = Styles.background(.secondary)
        }
    }
}
