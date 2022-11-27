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
    
    var searchResultData = [WordData]()
    
    let searchStackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .horizontal
        return view
    }()
    
    let searchBar: UISearchBar = {
        let view = UISearchBar()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.placeholder = "Enter a word here!"
        view.searchBarStyle = .minimal
        view.showsCancelButton = false
        view.showsBookmarkButton = false
        return view
    }()
    
    lazy var searchButton: UIButton = {
        var config = UIButton.Configuration.filled()
        config.cornerStyle = .large
        config.title = "Search"
        config.buttonSize = .mini
        config.baseBackgroundColor = Styles.background(.primary)
        
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.configuration = config
        button.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
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
        wordList.estimatedRowHeight = 100
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
    
    // MARK: - Actions
    
    @objc private func searchButtonTapped() {
        guard let query = searchBar.text else { return }
        wordDataFetcher.fetchWord(query) { [weak self] data in
            
            self?.searchResultData = data
            self?.wordList.reloadData()
        }
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
        
        cell.update(data: searchResultData[indexPath.row])
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
            UIView.animate(withDuration: 0.4) {
                cell.contentView.backgroundColor = Styles.background(.primary)
            }
            searchResultData[indexPath.row].isSelected = true
            
            navigationController?
                .pushViewController(WordDetailsViewController(data: searchResultData[indexPath.row]),
                                    animated: true)
        }
    }

    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? WordListTableViewCell {
            UIView.animate(withDuration: 0.4) {
                cell.contentView.backgroundColor = .init(white: 1, alpha: 0.5)
            }
            searchResultData[indexPath.row].isSelected = false
        }
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        if let cell = tableView.cellForRow(at: indexPath) as? WordListTableViewCell, let delegate = tableView.delegate {
            if cell.isSelected {
                _ = delegate.tableView?(tableView, willDeselectRowAt:indexPath)
                tableView.deselectRow(at: indexPath, animated: true)
                delegate.tableView?(tableView, didDeselectRowAt:indexPath)
                return nil
            }
        }
        return indexPath
    }
}

