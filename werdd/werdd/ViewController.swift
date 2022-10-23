//
//  ViewController.swift
//  werdd
//
//  Created by Virginia Bao on 10/4/22.
//

import UIKit

class ViewController: UIViewController {
    
    var data: [WordData]
    
    let wordListDelegate: WordListDelegate?
    
    let header: UILabel = {
        let label = UILabel()
        label.text = "werdd."
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Styles.text(.standard)
        label.font = Styles.font(size: .xlarge, style: .thick)
        return label
    }()
    
    let mainWordContainer: UIView = {
        let view = UIView()
        view.layer.cornerRadius = Padding.size(.rounding)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Styles.background(.accent)
        return view
    }()
    
    var wordCard: WordCardViewCell
    
    let wordList: WordListTableView
    
    lazy var refreshCardButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(Image.image(symbol: .refresh, size: .medium), for: .normal)
        button.addTarget(self, action: #selector(refreshKnowledgeCard), for: .touchUpInside)
        button.tintColor = Styles.background(.white)
        return button
    }()
    
    // MARK: - init
    
    init(using data: [WordData]) {
        self.data = data
        let highlightedWord = Self.getRandomWord(from: data)
        self.wordCard = WordCardViewCell(with: highlightedWord)
        self.wordList = WordListTableView(data: data,
                                          word: highlightedWord,
                                          wordCardDelegate: wordCard)
        self.wordListDelegate = wordList
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Styles.background(.background)
        setUpViews()
        setUpConstraints()
    }
    
    // MARK: - Set up UI
    
    private func setUpViews() {
        view.addSubview(header)
        view.addSubview(mainWordContainer)
        view.addSubview(wordList)
        mainWordContainer.addSubview(wordCard)
        mainWordContainer.addSubview(refreshCardButton)
    }

    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            header.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Padding.size(.large)),
            header.bottomAnchor.constraint(equalTo: mainWordContainer.topAnchor, constant: Padding.size(.medium) * -1),
            header.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Padding.size(.large)),
            header.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: Padding.size(.large) * -1),
            
            mainWordContainer.heightAnchor.constraint(greaterThanOrEqualToConstant: 150),
            mainWordContainer.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Padding.size(.large)),
            mainWordContainer.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: Padding.size(.large) * -1),
            
            wordCard.leadingAnchor.constraint(equalTo: mainWordContainer.leadingAnchor),
            wordCard.trailingAnchor.constraint(equalTo: mainWordContainer.trailingAnchor),
            wordCard.topAnchor.constraint(equalTo: mainWordContainer.topAnchor),
            wordCard.bottomAnchor.constraint(lessThanOrEqualTo: refreshCardButton.topAnchor),
            
            refreshCardButton.trailingAnchor.constraint(equalTo: mainWordContainer.trailingAnchor, constant: Padding.size(.small) * -1),
            refreshCardButton.bottomAnchor.constraint(equalTo: mainWordContainer.bottomAnchor, constant: Padding.size(.small) * -1),
            
            wordList.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            wordList.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            wordList.topAnchor.constraint(equalTo: mainWordContainer.bottomAnchor, constant: Padding.size(.medium)),
            wordList.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            wordList.heightAnchor.constraint(greaterThanOrEqualToConstant: 350)
        ])
    }
    
    // MARK: - Private helper functions
    
    @objc private func refreshKnowledgeCard() {
        let newWord = Self.getRandomWord(from: data)
        wordListDelegate?.update(highlightedWord: newWord)
        wordCard.updateCell(with: newWord)
    }
    
    private static func getRandomWord(from dataset: [WordData]) -> WordData? {
        dataset.randomElement() ?? nil
    }
}

