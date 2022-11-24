//
//  ViewController.swift
//  werdd
//
//  Created by Virginia Bao on 10/4/22.
//

import UIKit

class MainViewController: UIViewController {
    
    let wordDataFetcher: WordDataFetcher
    
    var highlightedWord: RequestWordData?
    
    var searchResults: [RequestWordData] = []
    
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
    
    init(wordDataFetcher: WordDataFetcher) {
        self.wordDataFetcher = wordDataFetcher
        self.wordCard = WordCardViewCell(with: highlightedWord)
        self.wordList = WordListTableView()
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle methods
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        wordDataFetcher.fetchRandomWord() { [weak self] word in
            self?.highlightedWord = word
            self?.wordCard.updateCell(with: word)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Styles.background(.background)
        navigationItem.title = "werdd"
        let attributes = [
            NSAttributedString.Key.font: Styles.font(size: .xlarge, style: .thick),
            NSAttributedString.Key.foregroundColor: Styles.textColor(.standard),
        ]
        navigationController?.navigationBar.titleTextAttributes = attributes
        
        setUpViews()
        setUpConstraints()
        
        wordList.delegate = self
        wordList.dataSource = self
        wordList.register(WordListTableViewCell.self, forCellReuseIdentifier: "WordListTableViewCell")
        wordList.rowHeight = UITableView.automaticDimension
        wordList.estimatedRowHeight = 80
        
        /// Swipe to next view controller
        let swipeGestureRecognizerLeft = UISwipeGestureRecognizer(target: self,
                                                                  action: #selector(didSwipe(_:)))
        swipeGestureRecognizerLeft.direction = .left
        mainWordContainer.addGestureRecognizer(swipeGestureRecognizerLeft)
    }
    
    // MARK: - Set up UI
    
    private func setUpViews() {
        view.addSubview(mainWordContainer)
        view.addSubview(wordList)
        mainWordContainer.addSubview(wordCard)
        mainWordContainer.addSubview(refreshCardButton)
    }

    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            mainWordContainer.heightAnchor.constraint(greaterThanOrEqualToConstant: 250),
            mainWordContainer.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mainWordContainer.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Padding.size(.large)),
            mainWordContainer.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: Padding.size(.large) * -1),
            
            wordCard.leadingAnchor.constraint(equalTo: mainWordContainer.leadingAnchor),
            wordCard.trailingAnchor.constraint(equalTo: mainWordContainer.trailingAnchor),
            wordCard.topAnchor.constraint(equalTo: mainWordContainer.topAnchor),
            
            refreshCardButton.topAnchor.constraint(equalTo: wordCard.bottomAnchor, constant: Padding.size(.small)),
            refreshCardButton.trailingAnchor.constraint(equalTo: mainWordContainer.trailingAnchor, constant: Padding.size(.small) * -1),
            refreshCardButton.bottomAnchor.constraint(equalTo: mainWordContainer.bottomAnchor, constant: Padding.size(.small) * -1),
            
            wordList.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            wordList.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            wordList.topAnchor.constraint(equalTo: mainWordContainer.bottomAnchor, constant: Padding.size(.medium)),
            wordList.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            wordList.heightAnchor.constraint(greaterThanOrEqualToConstant: 500)
        ])
    }
    
    // MARK: - Private helper functions
    
    @objc private func didSwipe(_ sender: UISwipeGestureRecognizer) {
        navigationController?.pushViewController(WordDetailsViewController(word: highlightedWord),
                                                 animated: true)
    }
    
    @objc private func refreshKnowledgeCard() {
        wordDataFetcher.fetchRandomWord() { [weak self] word in
            self?.highlightedWord = word
            self?.wordCard.updateCell(with: word)
        }
    }
}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        searchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "WordListTableViewCell", for: indexPath) as? WordListTableViewCell else {
            return UITableViewCell()
        }
        let word = searchResults[indexPath.row]
        cell.update(with: word)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? WordListTableViewCell {
            cell.didSelect()
        }

        // TODO: - On tap, show word details screen for the word card
    }

    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? WordListTableViewCell {
            cell.didDeselect()
        }
    }
}
