//
//  WordCard.swift
//  werdd
//
//  Created by Virginia Bao on 10/15/22.
//

import Foundation
import UIKit

class WordCardViewCell: UIView {
    
    // MARK: - init
    
    init(with data: RequestWordData?) {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        setUpViews()
        setUpConstraints()
        
        setWord()
        setPartOfSpeech()
        setDefinition()
        updateCell(with: data?.word, data: data?.results[0])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let title: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.alignment = .lastBaseline
        view.axis = .horizontal
        view.spacing = Padding.size(.small)
        return view
    }()
    
    var word: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var partOfSpeech: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var definition: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    var height: CGFloat {
        (self.subviews.map { $0.frame.height }).reduce(into: 0) { partial, element in
            partial += element
        }
    }
    
    // MARK: - Set up UI
    
    private func setUpViews() {
        addSubview(title)
        addSubview(definition)
        title.addArrangedSubview(word)
        title.addArrangedSubview(partOfSpeech)
    }
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            title.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Padding.size(.medium)),
            title.topAnchor.constraint(equalTo: topAnchor, constant: Padding.size(.medium)),
            title.bottomAnchor.constraint(equalTo: definition.topAnchor, constant: Padding.size(.xsmall) * -1),
            title.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: Padding.size(.medium) * -1),
            
            definition.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Padding.size(.medium)),
            definition.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: Padding.size(.medium) * -1),
            definition.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor, constant: Padding.size(.medium) * -1),
        ])
    }
    
    // MARK: - Helper functions
    
    func setWord(font: UIFont = Styles.font(size: .large, style: .thick),
             color: UIColor = Styles.textColor(.standard)) {
        word.font = font
        word.textColor = color
    }
    
    func setPartOfSpeech(font: UIFont = Styles.font(size: .small, style: .standard_italic),
             color: UIColor = Styles.textColor(.standard)) {
        partOfSpeech.font = font
        partOfSpeech.textColor = color
    }
    
    func setDefinition(font: UIFont = Styles.font(size: .standard, style: .standard),
             color: UIColor = Styles.textColor(.standard)) {
        definition.font = font
        definition.textColor = color
    }
    
    func updateCell(with newWord: String?, data: WordData?) {
        if let data = data {
            word.text = newWord
            partOfSpeech.text = data.partOfSpeech
            definition.text = data.definition
        } else {
            word.text = NSLocalizedString("Error", comment: "Error title")
            partOfSpeech.text = ""
            definition.text = NSLocalizedString("No word available!", comment: "Error message if there is no data from API call")
        }
    }
}
