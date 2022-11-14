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
    case none = "No word selected!"
}

class WordDetailsCell: UIView {

    let cardType: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Styles.textColor(.white)
        label.font = Styles.font(size: .standard, style: .bold)
        return label
    }()
    
    let content: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Styles.textColor(.standard)
        label.font = Styles.font(size: .standard, style: .standard)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
    }()
    
    let partOfSpeech: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Styles.textColor(.standard)
        label.font = Styles.font(size: .standard, style: .bold_italic)
        label.isHidden = true
        return label
    }()
    
    init(type: WordDetailType = .none, content: String?, partOfSpeech: String? = nil) {
        super.init(frame: .zero)
        self.cardType.text = type.rawValue
        self.content.text = content ?? "n/a"
        
        if let partOfSpeech = partOfSpeech {
            self.partOfSpeech.text = partOfSpeech
            self.partOfSpeech.isHidden = false
        }
        
        switch type {
        case .definition:
            backgroundColor = Styles.background(.accent)
        case .synonym:
            backgroundColor = Styles.background(.secondary)
            cardType.textColor = .black
        case .antonym:
            backgroundColor = Styles.background(.secondary)
            cardType.textColor = .black
        case .example:
            backgroundColor = Styles.background(.primary)
        case .none:
            backgroundColor = Styles.background(.background)
        }
        
        setUpViews()
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Set up UI
    
    private func setUpViews() {
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = Padding.size(.rounding)
        
        addSubview(partOfSpeech)
        addSubview(content)
        addSubview(cardType)
    }
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            partOfSpeech.topAnchor.constraint(equalTo: topAnchor, constant: Padding.size(.medium)),
            partOfSpeech.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Padding.size(.medium)),
            partOfSpeech.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Padding.size(.medium) * -1),
            
            content.topAnchor.constraint(equalTo: partOfSpeech.bottomAnchor, constant: Padding.size(.xsmall)),
            content.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Padding.size(.medium)),
            content.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Padding.size(.medium) * -1),
            
            cardType.topAnchor.constraint(equalTo: content.bottomAnchor, constant: Padding.size(.xsmall)),
            cardType.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Padding.size(.medium)),
            cardType.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Padding.size(.medium) * -1),
            cardType.bottomAnchor.constraint(equalTo: bottomAnchor, constant: Padding.size(.medium) * -1),
        ])
    }
}
