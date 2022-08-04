//
//  ViewController.swift
//  TrueOrFalse
//
//  Created by Кирилл Пономаренко on 04.08.2022.
//

import UIKit

class FirstViewController: UIViewController {
    
    private lazy var previousScoreLabel: UILabel = {
        let label = UILabel()
        label.text = "Previous score: 0"
        label.layer.cornerRadius = 25
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()

    private lazy var startGameButton: UIButton = {
        let button = UIButton()
        button.setTitle("Start game", for: .normal)
        button.layer.cornerRadius = 25
        button.backgroundColor = .init(red: 161 / 255, green: 22 / 255, blue: 204 / 255, alpha: 1)
        button.addTarget(self, action: #selector(start), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setConstraints()
        
        view.backgroundColor = .white
       
    }
    
    @objc func start() {
        
        print("Game start..")
    }
    
    private func setConstraints() {
        
        view.addSubviews(startGameButton, previousScoreLabel)
        
        startGameButton.translatesAutoresizingMaskIntoConstraints = false
        previousScoreLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            startGameButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 500),
            startGameButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 100),
            startGameButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -100),
            startGameButton.widthAnchor.constraint(equalToConstant: 100),
            startGameButton.heightAnchor.constraint(equalToConstant: 60),
            
//            previousScoreLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 450),
            previousScoreLabel.bottomAnchor.constraint(equalTo: startGameButton.topAnchor, constant: -50),
            previousScoreLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 100),
            previousScoreLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -100),
//            previousScoreLabel.widthAnchor.constraint(equalToConstant: 150),
//            previousScoreLabel.heightAnchor.constraint(equalToConstant: 50)
            
        ])
    }


}

extension UIView {
    func addSubviews(_ subviews: UIView...) {
        subviews.forEach { addSubview($0) }
        
}
    
}
