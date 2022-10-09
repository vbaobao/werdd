//
//  ViewController.swift
//  werdd
//
//  Created by Virginia Bao on 10/4/22.
//

import UIKit

class ViewController: UIViewController {
    enum Padding: CGFloat {
        case xsmall = 8
        case small = 12
        case medium = 16
        case large = 24
        case rounding = 18
        
        static func size(_ padding: Padding) -> CGFloat {
            padding.rawValue
        }
    }
    
    let header: UILabel = {
        let label = UILabel()
        label.text = "werdd."
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Style.text(.standard)
        label.font = Style.font(size: .xlarge, style: .thick)
        return label
    }()
    
    let knowledgeCard: UIView = {
        let view = UIView()
        view.layer.cornerRadius = Padding.size(.rounding)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Style.background(.accent)
        return view
    }()
    
    let knowledgeCardTitle: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.alignment = .lastBaseline
        view.axis = .horizontal
        view.spacing = Padding.size(.small)
        return view
    }()
    
    let knowledgeCardWord: UILabel = {
        let label = UILabel()
        label.text = "cat"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Style.text(.standard)
        label.font = Style.font(size: .large, style: .thick)
        return label
    }()
    
    let knowledgeCardPartOfSpeech: UILabel = {
        let label = UILabel()
        label.text = "noun"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Style.text(.standard)
        label.font = Style.font(size: .small, style: .standard_italic)
        return label
    }()
    
    let knowledgeCardDefinition: UILabel = {
        let label = UILabel()
        label.text = "a small domesticated carnivorous mammal with soft fur, a short snout, and retractable claws. It is widely kept as a pet or for catching mice, and many breeds have been developed."
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Style.text(.standard)
        label.font = Style.font(size: .standard, style: .standard)
        label.numberOfLines = 5
        label.lineBreakMode = .byWordWrapping
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Style.background(.background)
        view.addSubview(header)
        view.addSubview(knowledgeCard)
        knowledgeCard.addSubview(knowledgeCardTitle)
        knowledgeCard.addSubview(knowledgeCardDefinition)
        knowledgeCardTitle.addArrangedSubview(knowledgeCardWord)
        knowledgeCardTitle.addArrangedSubview(knowledgeCardPartOfSpeech)
        
        setUpConstraints()
    }

    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            header.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Padding.size(.large)),
            header.bottomAnchor.constraint(equalTo: knowledgeCard.topAnchor, constant: Padding.size(.medium) * -1),
            header.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Padding.size(.large)),
            header.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Padding.size(.large) * -1),
            
            knowledgeCard.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.3),
            knowledgeCard.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Padding.size(.large)),
            knowledgeCard.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Padding.size(.large) * -1),
            
            knowledgeCardTitle.leadingAnchor.constraint(equalTo: knowledgeCard.leadingAnchor, constant: Padding.size(.medium)),
            knowledgeCardTitle.topAnchor.constraint(equalTo: knowledgeCard.topAnchor, constant: Padding.size(.medium)),
            knowledgeCardTitle.bottomAnchor.constraint(equalTo: knowledgeCardDefinition.topAnchor, constant: Padding.size(.xsmall) * -1),
            knowledgeCardTitle.trailingAnchor.constraint(lessThanOrEqualTo: knowledgeCard.trailingAnchor, constant: Padding.size(.medium) * -1),
            
//            knowledgeCardWord.trailingAnchor.constraint(equalTo: knowledgeCardPartOfSpeech.leadingAnchor, constant: Padding.size(.small) * -1),
            
            knowledgeCardDefinition.leadingAnchor.constraint(equalTo: knowledgeCard.leadingAnchor, constant: Padding.size(.medium)),
            knowledgeCardDefinition.trailingAnchor.constraint(equalTo: knowledgeCard.trailingAnchor, constant: Padding.size(.medium) * -1),
            
        ])
    }
}

