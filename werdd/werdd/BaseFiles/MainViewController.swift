//
//  ViewController.swift
//  werdd
//
//  Created by Virginia Bao on 10/4/22.
//

import UIKit

class MainViewController: UIViewController {
    
    let highlightedWordCardVCContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let searchWordListVCContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - Initializers
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        setUpConstraints()
        
        /// Set up navigation controller
        navigationItem.title = "werdd"
        let attributes = [
            NSAttributedString.Key.font: Styles.font(size: .xlarge, style: .thick),
            NSAttributedString.Key.foregroundColor: Styles.textColor(.standard),
        ]
        navigationController?.navigationBar.titleTextAttributes = attributes
        
        /// Set up child view controllers
        let randomWordCardViewController = RandomWordCardViewController()
        addChild(randomWordCardViewController)
        highlightedWordCardVCContainer.addSubview(randomWordCardViewController.view)
        randomWordCardViewController.didMove(toParent: self)
        randomWordCardViewController.view.frame = highlightedWordCardVCContainer.frame
        
        let wordListViewController = WordListViewController()
        addChild(wordListViewController)
        searchWordListVCContainer.addSubview(wordListViewController.view)
        wordListViewController.didMove(toParent: self)
        wordListViewController.view.frame = searchWordListVCContainer.frame
    }
    
    // MARK: - Set up functions
    
    private func setUpUI() {
        view.backgroundColor = Styles.background(.background)
        view.addSubview(highlightedWordCardVCContainer)
        view.addSubview(searchWordListVCContainer)
    }
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            highlightedWordCardVCContainer.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            highlightedWordCardVCContainer.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            highlightedWordCardVCContainer.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            highlightedWordCardVCContainer.bottomAnchor.constraint(equalTo: searchWordListVCContainer.topAnchor),
            
            searchWordListVCContainer.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            searchWordListVCContainer.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            searchWordListVCContainer.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            searchWordListVCContainer.heightAnchor.constraint(greaterThanOrEqualTo: view.heightAnchor, multiplier: 0.5),
        ])
    }
}
