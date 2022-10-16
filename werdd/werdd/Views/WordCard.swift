//
//  WordCard.swift
//  werdd
//
//  Created by Virginia Bao on 10/15/22.
//

import Foundation
import UIKit

class WordCard: UIView {
    
    // MARK: - init
    
    init(with data: Data?) {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        setUpViews()
        setUpConstraints()
        updateCell(with: data)
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
        label.textColor = Style.text(.standard)
        label.font = Style.font(size: .large, style: .thick)
        return label
    }()
    
    var partOfSpeech: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Style.text(.standard)
        label.font = Style.font(size: .small, style: .standard_italic)
        return label
    }()
    
    var definition: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Style.text(.standard)
        label.font = Style.font(size: .standard, style: .standard)
        label.numberOfLines = 5
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    // MARK: - Set up UI
    
    private func setUpViews() {
        addSubview(title)
        addSubview(definition)
        title.addArrangedSubview(word)
        title.addArrangedSubview(partOfSpeech)
    }
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            title.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Padding.size(.medium)),
            title.topAnchor.constraint(equalTo: self.topAnchor, constant: Padding.size(.medium)),
            title.bottomAnchor.constraint(equalTo: definition.topAnchor, constant: Padding.size(.xsmall) * -1),
            title.trailingAnchor.constraint(lessThanOrEqualTo: self.trailingAnchor, constant: Padding.size(.medium) * -1),
            
            definition.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Padding.size(.medium)),
            definition.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: Padding.size(.medium) * -1),
        ])
    }
    
    // MARK: - Helper functions
    
    func updateCell(with data: Data?) {
        if let data = data {
            word.text = data.word
            partOfSpeech.text = data.partOfSpeech.localizedString
            definition.text = data.definition
        } else {
            word.text = NSLocalizedString("Error", comment: "Error title")
            partOfSpeech.text = ""
            definition.text = NSLocalizedString("No word available!", comment: "Error message if there is no data from API call")
        }
    }
}
