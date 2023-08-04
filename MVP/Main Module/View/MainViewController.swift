//
//  MainViewController.swift
//  MVP
//
//  Created by Sergei Semko on 8/4/23.
//

import UIKit


// Main View
class MainViewController: UIViewController {
    
    // MARK: - IBOutlet
    private let greetingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    private let button: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Button", for: .normal)
        return button
    }()
    
    var presenter: MainViewPresenterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupConstraints()
    }
    
    private func setupViews() {
        view.backgroundColor = .systemBackground
        view.addSubview(greetingLabel)
        view.addSubview(button)
        
        greetingLabel.text = "Test"
        button.addTarget(self, action: #selector(didTapButtonAction), for: .touchUpInside)
    }

    @objc
    private func didTapButtonAction(_ sender: Any) {
        self.presenter?.showGreeting()
    }

}

extension MainViewController: MainViewProtocol {
    func setGreeting(greeting: String) {
        self.greetingLabel.text = greeting
    }
}

// MARK: - Setup Constraints

extension MainViewController {
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            greetingLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            greetingLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            button.topAnchor.constraint(equalTo: greetingLabel.bottomAnchor, constant: 30),
            button.centerXAnchor.constraint(equalTo: greetingLabel.centerXAnchor),
        ])
    }
}
