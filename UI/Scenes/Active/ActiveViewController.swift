//
//  ActiveViewController.swift
//  UI
//
//  Created by Wagner Coleta on 19/02/22.
//

import Foundation
import UIKit
import Presentation

final class ActiveViewController: UIViewController {
    
    @IBOutlet weak var loadingIncator: UIActivityIndicatorView!
    @IBOutlet weak var loadButton: UIButton!
    @IBOutlet weak var codeActiveTextField: UITextField!
    
    var listActive: ((ReadActiveViewModel) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    private func configure() {
        loadButton?.addTarget(self, action: #selector(loadButtonTapped), for: .touchUpInside)
    }
    
    @objc private func loadButtonTapped() {
        let codeActive = codeActiveTextField?.text
        var codes = [String]()
        codes.append(codeActive!)
        listActive?(ReadActiveViewModel(codes: codes))
    }
}

extension ActiveViewController: LoadingView {
    func display(viewModel: LoadingViewModel) {
        if viewModel.isLoading {
            loadingIncator?.startAnimating()
        } else {
            loadingIncator?.stopAnimating()
        }
    }
}

extension ActiveViewController: AlertView {
    func showMessage(viewModel: AlertViewModel) {
        let alert = UIAlertController(title: viewModel.title, message: viewModel.message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        present(alert, animated: true)
    }
}
