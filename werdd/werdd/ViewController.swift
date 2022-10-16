//
//  ViewController.swift
//  werdd
//
//  Created by Virginia Bao on 10/4/22.
//

import UIKit

class ViewController: UIViewController {
    var data: [Data]
    
    let header: UILabel = {
        let label = UILabel()
        label.text = "werdd."
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Style.text(.standard)
        label.font = Style.font(size: .xlarge, style: .thick)
        return label
    }()
    
    let mainWordContainer: UIView = {
        let view = UIView()
        view.layer.cornerRadius = Padding.size(.rounding)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Style.background(.accent)
        return view
    }()
    
    var wordCard: WordCard
    
    lazy var refreshCardButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(Image.image(symbol: .refresh, size: .medium), for: .normal)
        button.addTarget(self, action: #selector(refreshKnowledgeCard), for: .touchUpInside)
        button.tintColor = Style.background(.white)
        return button
    }()
    
    // MARK: - init
    
    init(using data: [Data]) {
        self.data = data
        self.wordCard = WordCard(with: Self.getRandomWord(from: data))
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Style.background(.background)
        view.addSubview(header)
        view.addSubview(mainWordContainer)
        mainWordContainer.addSubview(wordCard)
        mainWordContainer.addSubview(refreshCardButton)
        
        setUpConstraints()
        setUpViews()
    }
    
    // MARK: - Set up UI
    
    private func setUpViews() {
        view.backgroundColor = Style.background(.background)
        view.addSubview(header)
        view.addSubview(mainWordContainer)
        mainWordContainer.addSubview(wordCard)
        mainWordContainer.addSubview(refreshCardButton)
    }

    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            header.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Padding.size(.large)),
            header.bottomAnchor.constraint(equalTo: mainWordContainer.topAnchor, constant: Padding.size(.medium) * -1),
            header.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Padding.size(.large)),
            header.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Padding.size(.large) * -1),
            
            mainWordContainer.heightAnchor.constraint(greaterThanOrEqualToConstant: 200),
            mainWordContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Padding.size(.large)),
            mainWordContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Padding.size(.large) * -1),
            
            wordCard.leadingAnchor.constraint(equalTo: mainWordContainer.leadingAnchor),
            wordCard.trailingAnchor.constraint(equalTo: mainWordContainer.trailingAnchor),
            wordCard.topAnchor.constraint(equalTo: mainWordContainer.topAnchor),
            wordCard.bottomAnchor.constraint(lessThanOrEqualTo: refreshCardButton.topAnchor),
            
            refreshCardButton.trailingAnchor.constraint(equalTo: mainWordContainer.trailingAnchor, constant: Padding.size(.small) * -1),
            refreshCardButton.bottomAnchor.constraint(equalTo: mainWordContainer.bottomAnchor, constant: Padding.size(.small) * -1)
        ])
    }
    
    // MARK: - Private helper functions
    
    @objc private func refreshKnowledgeCard() {
        let newWord = Self.getRandomWord(from: data)
        wordCard.updateCell(with: newWord)
    }
    
    private static func getRandomWord(from dataset: [Data]) -> Data? {
        dataset.randomElement() ?? nil
    }
}

