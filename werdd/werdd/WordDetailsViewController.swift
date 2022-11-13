//
//  WordDetailsViewController.swift
//  werdd
//
//  Created by Virginia Bao on 11/13/22.
//

import UIKit

class WordDetailsViewController: UIViewController {
    
    var word: WordData?
    
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
    }
    
    // MARK: - Set up UI
    
    private func setUpViews() {}
    
    private func setUpConstraints() {}
}
