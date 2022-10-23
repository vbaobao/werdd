//
//  WordListTableView.swift
//  werdd
//
//  Created by Virginia Bao on 10/16/22.
//

import Foundation
import UIKit

class WordListTableView: UITableView {
    var data: [WordData]
    var wordList: [WordData]
    var wordCardDelegate: WordCardDelegate?
    
    init(data: [WordData], word: WordData?, wordCardDelegate: WordCardDelegate?) {
        self.data = data
        self.wordList = Self.get(wordListWithoutHighlightedWord: word, from: data)
        self.wordCardDelegate = wordCardDelegate
        
        super.init(frame: .zero, style: .plain)
        dataSource = self
        delegate = self
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Set up UI
    
    private func setUpUI() {
        translatesAutoresizingMaskIntoConstraints = false
        showsVerticalScrollIndicator = false
        contentInset = UIEdgeInsets(top: Padding.medium.rawValue,
                                    left: 0,
                                    bottom: Padding.large.rawValue,
                                    right: 0)
        backgroundColor = Styles.background(.secondary)
        layer.cornerRadius = Padding.rounding.rawValue
        layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
    // MARK: - Private helper functions
    
    private static func get(wordListWithoutHighlightedWord highlightedWord: WordData?,
                            from wordList: [WordData]) -> [WordData] {
        wordList.reduce(into: []) { partialResult, currentWord in
            if highlightedWord != currentWord {
                partialResult.append(currentWord)
            }
        }
    }
}

extension WordListTableView: WordListDelegate {
    func update(highlightedWord newWord: WordData?) {
        wordList = Self.get(wordListWithoutHighlightedWord: newWord, from: data)
        self.reloadSections(IndexSet(integer: 0), with: .fade)
    }
}

extension WordListTableView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        wordList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let word = wordList[indexPath.row]
        let cell = UITableViewCell(style: .default, reuseIdentifier: UUID().uuidString)
        var content = cell.defaultContentConfiguration()
        content.text = word.word + " • " + word.partOfSpeech.localizedString
        content.secondaryText = word.definition
        
        cell.contentConfiguration = content
        cell.backgroundColor = Styles.background(.secondary)
        return cell
    }
}

extension WordListTableView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let newWord = wordList[indexPath.row]
        wordCardDelegate?.update(wordCard: newWord)
        update(highlightedWord: newWord)
    }
}
