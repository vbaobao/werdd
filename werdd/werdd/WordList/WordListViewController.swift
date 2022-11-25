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
    
    var searchResultData: [RequestWordData] = []
    
    let searchStackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .horizontal
        return view
    }()
    
    let searchBar: UISearchBar = {
        let view = UISearchBar()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.placeholder = "Search"
        view.searchBarStyle = .minimal
        view.showsCancelButton = false
        view.showsBookmarkButton = false
        return view
    }()
    
    let searchButton: UIButton = {
        var config = UIButton.Configuration.filled()
        config.cornerStyle = .large
        config.title = "Search"
        config.buttonSize = .mini
        config.baseBackgroundColor = Styles.background(.primary)
        
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.configuration = config
        return button
    }()
    
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
        view.backgroundColor = Styles.background(.secondary)
        view.layer.cornerRadius = Padding.rounding.rawValue
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        view.addSubview(searchStackView)
        view.addSubview(wordList)
        
        searchStackView.addArrangedSubview(searchBar)
        searchStackView.addArrangedSubview(searchButton)
    }

    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            searchStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Padding.size(.small)),
            searchStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Padding.size(.xsmall)),
            searchStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: Padding.size(.small) * -1),
            
            wordList.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            wordList.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            wordList.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: Padding.size(.medium)),
            wordList.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            searchButton.heightAnchor.constraint(equalToConstant: 36)
        ])
    }
}

extension WordListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        searchResultData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "WordListTableViewCell", for: indexPath) as? WordListTableViewCell else {
            return UITableViewCell()
        }
        let word = searchResultData[indexPath.row]
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

