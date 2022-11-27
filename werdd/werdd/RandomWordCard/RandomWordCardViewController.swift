//
//  RandomWordCardViewController.swift
//  werdd
//
//  Created by Virginia Bao on 11/23/22.
//

import Foundation
import UIKit

class RandomWordCardViewController: UIViewController {
    let wordDataFetcher = WordDataFetcher()
    
    var highlightedWord: WordData?
    
    let mainWordContainer: UIView = {
        let view = UIView()
        view.layer.cornerRadius = Padding.size(.rounding)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Styles.background(.accent)
        return view
    }()
    
    var wordCard = WordCardViewCell(with: WordData(word: "",
                                                   definition: "No word selected!",
                                                   partOfSpeech: "",
                                                   synonyms: nil,
                                                   antonyms: nil,
                                                   examples: nil))
    
    lazy var refreshCardButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(Image.image(symbol: .refresh, size: .medium), for: .normal)
        button.addTarget(self, action: #selector(refreshKnowledgeCard), for: .touchUpInside)
        button.tintColor = Styles.background(.white)
        return button
    }()
    
    // MARK: - init
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle methods
    
    override func viewDidLoad() {
        wordDataFetcher.fetchRandomWord() { [weak self] result in
            self?.highlightedWord = result
            self?.wordCard.updateCell(data: result)
        }
        
        super.viewDidLoad()
        setUpViews()
        setUpConstraints()
        
        /// Swipe to next view controller
        let swipeGestureRecognizerLeft = UISwipeGestureRecognizer(target: self,
                                                                  action: #selector(didSwipe(_:)))
        swipeGestureRecognizerLeft.direction = .left
        view.addGestureRecognizer(swipeGestureRecognizerLeft)
    }
    
    // MARK: - Set up UI
    
    private func setUpViews() {
        view.backgroundColor = Styles.background(.background)
        view.layer.cornerRadius = Padding.size(.rounding)
        
        view.addSubview(mainWordContainer)
        mainWordContainer.addSubview(wordCard)
        mainWordContainer.addSubview(refreshCardButton)
    }

    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            mainWordContainer.topAnchor.constraint(equalTo: view.topAnchor, constant: Padding.size(.medium)),
            mainWordContainer.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: Padding.size(.medium) * -1),
            mainWordContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Padding.size(.large)),
            mainWordContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Padding.size(.large) * -1),
            
            wordCard.leadingAnchor.constraint(equalTo: mainWordContainer.leadingAnchor),
            wordCard.trailingAnchor.constraint(equalTo: mainWordContainer.trailingAnchor),
            wordCard.topAnchor.constraint(equalTo: mainWordContainer.topAnchor),
            
            refreshCardButton.topAnchor.constraint(equalTo: wordCard.bottomAnchor, constant: Padding.size(.small)),
            refreshCardButton.trailingAnchor.constraint(equalTo: mainWordContainer.trailingAnchor, constant: Padding.size(.small) * -1),
            refreshCardButton.bottomAnchor.constraint(equalTo: mainWordContainer.bottomAnchor, constant: Padding.size(.small) * -1),
        ])
    }
    
    // MARK: - Private helper functions
    
    @objc private func didSwipe(_ sender: UISwipeGestureRecognizer) {
        if let highlightedWord = highlightedWord {
            navigationController?.pushViewController(WordDetailsViewController(data: highlightedWord),
                                                     animated: true)
        }
    }
    
    @objc private func refreshKnowledgeCard() {
        wordDataFetcher.fetchRandomWord() { [weak self] word in
            self?.highlightedWord = word
            self?.wordCard.updateCell(data: word)
        }
    }
}
