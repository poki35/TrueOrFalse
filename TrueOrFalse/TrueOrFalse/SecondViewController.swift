//
//  SecondViewController.swift
//  TrueOrFalse
//
//  Created by Кирилл Пономаренко on 04.08.2022.
//

import UIKit

class SecondViewController: UIViewController {
    
    var mainScore = 0
    var num1 = 0
    var num2 = 0
    let minRand = 1
    let maxRand = 100
    
    var timeLeft: Float = 2.0
    var givenTime: Float = 20.0
    var progress: Float = 3.0
    var answer = false
    var timeStep: Float = 0.02

    
    var timer: Timer?
    
    private lazy var progressView: UIProgressView = {
        let view = UIProgressView()
        return view
    }()
    
    private lazy var scoreLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "Score: 0"
        label.font = UIFont.systemFont(ofSize: 25)
        return label
    }()
    
    private lazy var trueButton: UIButton = {
        let button = UIButton()
        button.setTitle("TRUE", for: .normal)
        button.backgroundColor = .blue
        button.addTarget(self, action: #selector(trueButtonAction), for: .touchUpInside)
        return button
    }()
    
    private lazy var falseButton: UIButton = {
        let button = UIButton()
        button.setTitle("FALSE", for: .normal)
        button.backgroundColor = .red
        button.addTarget(self, action: #selector(falseButtonAction), for: .touchUpInside)
        return button
    }()
    
    private lazy var numLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = .black
        return label
    }()
    
    private lazy var separatingLine: UIView = {
        let line = UIView()
        line.backgroundColor = .black
        return line
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .init(red: 135 / 255, green: 206 / 255, blue: 235 / 255, alpha: 1)
        
        setup()
        setConstraints()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goBack" {
            let dest = segue.destination as! FirstViewController
            dest.previousScoreLabel = scoreLabel
        }
    }
    
    @objc func trueButtonAction() {
        answer = true
        checkUserAnswer()
        print("TRUE")
    }
    
    @objc func falseButtonAction() {
        answer = false
        checkUserAnswer()
        print("FALSE")
    }
    
    @objc func gameLoop() {
        timeLeft -= timeStep
        progress = timeLeft / givenTime
        progressView.setProgress(progress, animated: false)

        if timeLeft <= 0 {
            performSegue(withIdentifier: "goBack", sender: self)
        }
        timer = Timer.scheduledTimer(timeInterval: TimeInterval(timeStep), target: self, selector: #selector(gameLoop), userInfo: nil, repeats: false)
    }
    
    func setup() {
        mainScore = 0
        gameLoop()
        resetGame()
    }
    
    func checkUserAnswer() {
        if answer == (num1 > num2) {
            mainScore += 1
            scoreLabel.text = "Score: \(mainScore)"
            resetGame()
        } else {
            performSegue(withIdentifier: "goBack", sender: self)
        }
    }
    
    func resetGame() {
        num1 = Int(arc4random_uniform(UInt32(maxRand-minRand+1))) + minRand
        num2 = Int(arc4random_uniform(UInt32(maxRand-minRand+1))) + minRand
        
        numLabel.text = "\(num1) > \(num2)"
        
        timeLeft = givenTime
        progress = 1.0
        progressView.setProgress(progress, animated: false)
    }
    
    private func setConstraints() {
        
        view.addSubviews(scoreLabel, trueButton, falseButton, separatingLine, numLabel, progressView)
        
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        trueButton.translatesAutoresizingMaskIntoConstraints = false
        falseButton.translatesAutoresizingMaskIntoConstraints = false
        separatingLine.translatesAutoresizingMaskIntoConstraints = false
        numLabel.translatesAutoresizingMaskIntoConstraints = false
        progressView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            scoreLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            scoreLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            
            trueButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            trueButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            trueButton.widthAnchor.constraint(equalToConstant: 210),
            trueButton.heightAnchor.constraint(equalToConstant: 100),
            
            falseButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            falseButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            falseButton.widthAnchor.constraint(equalToConstant: 210),
            falseButton.heightAnchor.constraint(equalToConstant: 100),
            
            separatingLine.bottomAnchor.constraint(equalTo: trueButton.topAnchor, constant: 0),
            separatingLine.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            separatingLine.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            separatingLine.heightAnchor.constraint(equalToConstant: 1),
            
            numLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            numLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            numLabel.widthAnchor.constraint(equalToConstant: 200),
            numLabel.heightAnchor.constraint(equalToConstant: 100),
            
            progressView.bottomAnchor.constraint(equalTo: separatingLine.topAnchor, constant: 5),
            progressView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            progressView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            progressView.heightAnchor.constraint(equalToConstant: 10)
        ])
    }
    
}
