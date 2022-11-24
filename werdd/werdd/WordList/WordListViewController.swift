//
//  WordListViewController.swift
//  werdd
//
//  Created by Virginia Bao on 11/23/22.
//

import Foundation
import UIKit

class WordListViewController: UIViewController {
    let wordDataFetcher = WordDataFetcher()
    
    var searchResults: [RequestWordData] = []
    
    let wordList = WordListTableView()
    
    // MARK: - init
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle methods

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpViews()
        setUpConstraints()
        
        wordList.delegate = self
        wordList.dataSource = self
        wordList.register(WordListTableViewCell.self, forCellReuseIdentifier: "WordListTableViewCell")
        wordList.rowHeight = UITableView.automaticDimension
        wordList.estimatedRowHeight = 80
    }
    
    // MARK: - Set up UI
    
    private func setUpViews() {
        view.backgroundColor = Styles.background(.background)
        view.addSubview(wordList)
    }

    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            wordList.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            wordList.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            wordList.topAnchor.constraint(equalTo: view.topAnchor, constant: Padding.size(.medium)),
            wordList.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}

extension WordListViewController: UITableViewDataSource {
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

extension WordListViewController: UITableViewDelegate {
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

