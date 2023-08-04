//
//  DetailViewController.swift
//  MVP
//
//  Created by Sergei Semko on 8/4/23.
//

import UIKit

class DetailViewController: UIViewController {
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    var presenter: DetailViewPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        presenter?.setComment()
    }
    
    private func setupViews() {
        view.backgroundColor = .systemBackground
        view.addSubview(label)
    }
}

extension DetailViewController: DetailViewProtocol {
    func setComment(comment: Comment?) {
        label.text = comment?.body
    }
}

extension DetailViewController {
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            label.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
}
