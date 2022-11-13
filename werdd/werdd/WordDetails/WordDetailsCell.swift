//
//  WordDetailsCell.swift
//  werdd
//
//  Created by Virginia Bao on 11/13/22.
//

import UIKit

enum WordDetailType: String {
    case definition = "Definition"
    case synonym = "Synonym"
    case antonym = "Antonym"
    case example = "Example Usage"
}

class WordDetailsCell: UIView {

    let cardType: UILabel = {
        var label = UILabel()
        label.textColor = Styles.textColor(.white)
        label.font = Styles.font(size: .standard, style: .bold)
        return label
    }()
    
    let content: UILabel = {
        var label = UILabel()
        label.textColor = Styles.textColor(.standard)
        label.font = Styles.font(size: .standard, style: .standard)
        return label
    }()
    
    let partOfSpeech: UILabel = {
        var label = UILabel()
        label.textColor = Styles.textColor(.standard)
        label.font = Styles.font(size: .standard, style: .bold_italic)
        label.isHidden = true
        return label
    }()
    
    init(type: WordDetailType, content: String, partOfSpeech: String? = nil) {
        super.init(frame: .zero)
        self.cardType.text = type.rawValue
        self.content.text = content
        if let partOfSpeech = partOfSpeech {
            self.partOfSpeech.text = partOfSpeech
        }
        
        
        setUpViews()
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Set up UI
    
    private func setUpViews() {
    }
    
    private func setUpConstraints() {}
}
