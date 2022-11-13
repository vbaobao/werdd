//
//  WordDetailsViewController.swift
//  werdd
//
//  Created by Virginia Bao on 11/13/22.
//

import UIKit

class WordDetailsViewController: UIViewController {
    
    var word: WordData?
    
    var stackview: UIStackView = {
        var view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.spacing = Padding.medium.rawValue
        return view
    }()
    
    init(word: WordData?) {
        self.word = word
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = word?.word
        setUpUI()
        setUpConstraints()
        
        /// Swipe to next view controller
        let swipeGestureRecognizerRight = UISwipeGestureRecognizer(target: self,
                                                                  action: #selector(didSwipe(_:)))
        swipeGestureRecognizerRight.direction = .right
        stackview.addGestureRecognizer(swipeGestureRecognizerRight)
    }
    
    // MARK: - Set up UI
    
    private func setUpUI() {
        view.backgroundColor = Styles.background(.background)
        view.addSubview(stackview)
        
        if let word = word {
            stackview.addSubview(WordDetailsCell(type: .definition,
                                                 content: word.definition,
                                                 partOfSpeech: word.partOfSpeech.rawValue))
            if let synonym = word.synonym {
                stackview.addSubview(WordDetailsCell(type: .synonym,
                                                     content: synonym))
            }
            if let antonym = word.antonym {
                stackview.addSubview(WordDetailsCell(type: .antonym,
                                                     content: antonym))
            }
            stackview.addSubview(WordDetailsCell(type: .example,
                                                 content: word.example))
        }
        
        if let word = word {
            for (type, detail) in word.details {
                if let detail = detail {
                    if type == .definition {
                        stackview.addSubview(WordDetailsCell(type: type,
                                                        content: detail,
                                                        partOfSpeech: word.partOfSpeech.rawValue))
                    } else {
                        stackview.addSubview(WordDetailsCell(type: type,
                                                        content: detail))
                    }
                }
            }
        }
    }
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            stackview.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackview.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            stackview.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            stackview.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
    // MARK: - Actions
    
    @objc private func didSwipe(_ sender: UISwipeGestureRecognizer) {
        // Current Frame
        var frame = stackview.frame

        // New Frame
        frame.origin.x += 200.0
        UIView.animate(withDuration: 0.25) {
            self.stackview.frame = frame
        }
        
        navigationController?.popViewController(animated: true)
    }
}
