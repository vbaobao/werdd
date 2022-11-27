//
//  WordDetailsViewController.swift
//  werdd
//
//  Created by Virginia Bao on 11/13/22.
//

import UIKit

class WordDetailsViewController: UIViewController {
    
    var data: WordData
    
    var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var stackview: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = Padding.size(.small)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    init(data: WordData) {
        self.data = data
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = data.word
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
        view.addSubview(scrollView)
        scrollView.addSubview(stackview)
        addWordCellsAsSubview()
    }
    
    private func addWordCellsAsSubview() {
        stackview.addArrangedSubview(WordDetailsCell(type: .definition, content: data.definition, partOfSpeech: data.partOfSpeech))
        
        if let synonyms = data.synonyms {
            stackview.addArrangedSubview(WordDetailsCell(type: .synonym, content: synonyms.joined(separator: ", ")))
        }
        
        if let antonyms = data.antonyms {
            stackview.addArrangedSubview(WordDetailsCell(type: .antonym, content: antonyms.joined(separator: ", ")))
        }
        
        if let examples = data.examples {
            for example in examples {
                stackview.addArrangedSubview(WordDetailsCell(type: .example, content: example))
            }
        }
    }
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Padding.size(.medium)),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Padding.size(.medium)),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: Padding.size(.medium) * -1),
            
            stackview.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackview.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackview.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 1)
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
