//
//  WordDetailsViewController.swift
//  werdd
//
//  Created by Virginia Bao on 11/13/22.
//

import UIKit

class WordDetailsViewController: UIViewController {
    
    var word: WordData?
    
    var definition: WordDetailsCell
    
    var synonym: WordDetailsCell
    
    var antonym: WordDetailsCell
    
    var example: WordDetailsCell
    
    init(word: WordData?) {
        self.word = word
        self.definition = WordDetailsCell(type: .definition,
                                          content: word?.definition,
                                          partOfSpeech: word?.partOfSpeech.rawValue)
        self.synonym = WordDetailsCell(type: .synonym,
                                       content: word?.synonym)
        self.antonym = WordDetailsCell(type: .antonym,
                                       content: word?.antonym)
        self.example = WordDetailsCell(type: .example,
                                       content: word?.example)
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = word?.word
        navigationController?.navigationBar.tintColor = .black
        setUpUI()
        setUpConstraints()
        
        /// Swipe to next view controller
        let swipeGestureRecognizerRight = UISwipeGestureRecognizer(target: self,
                                                                  action: #selector(didSwipe(_:)))
        swipeGestureRecognizerRight.direction = .right
        view.addGestureRecognizer(swipeGestureRecognizerRight)
    }
    
    // MARK: - Set up UI
    
    private func setUpUI() {
        view.backgroundColor = Styles.background(.background)
        view.addSubview(definition)
        view.addSubview(synonym)
        view.addSubview(antonym)
        view.addSubview(example)
    }
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            definition.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Padding.size(.medium)),
            definition.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Padding.size(.medium)),
            definition.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: Padding.size(.medium) * -1),
            
            synonym.topAnchor.constraint(equalTo: definition.bottomAnchor, constant: Padding.size(.small)),
            synonym.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Padding.size(.medium)),
            synonym.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: Padding.size(.medium) * -1),
            
            antonym.topAnchor.constraint(equalTo: synonym.bottomAnchor, constant: Padding.size(.small)),
            antonym.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Padding.size(.medium)),
            antonym.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: Padding.size(.medium) * -1),
            
            example.topAnchor.constraint(equalTo: antonym.bottomAnchor, constant: Padding.size(.small)),
            example.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Padding.size(.medium)),
            example.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: Padding.size(.medium) * -1)
        ])
    }
    
    // MARK: - Actions
    
    @objc private func didSwipe(_ sender: UISwipeGestureRecognizer) {
        // Current Frame
        var frame = view.frame

        // New Frame
        frame.origin.x += 200.0
        UIView.animate(withDuration: 0.25) {
            self.view.frame = frame
        }
        
        navigationController?.popViewController(animated: true)
    }
}
