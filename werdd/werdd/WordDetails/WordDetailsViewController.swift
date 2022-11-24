//
//  WordDetailsViewController.swift
//  werdd
//
//  Created by Virginia Bao on 11/13/22.
//

import UIKit

class WordDetailsViewController: UIViewController {
    
    var word: RequestWordData?
    
    var stackview: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = Padding.size(.small)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    init(word: RequestWordData?) {
        self.word = word
        super.init(nibName: nil, bundle: nil)
        setUpUI()
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
        view.addSubview(stackview)
        // TODO: - Add subviews based on cells we need for this particular word
    }
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            stackview.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Padding.size(.medium)),
            stackview.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            stackview.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Padding.size(.medium)),
            stackview.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: Padding.size(.medium) * -1),
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
