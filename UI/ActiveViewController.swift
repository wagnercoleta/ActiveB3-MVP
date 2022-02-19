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
    
    var listActive: ((ReadActiveViewModel) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    private func configure() {
        loadButton?.addTarget(self, action: #selector(loadButtonTapped), for: .touchUpInside)
    }
    
    @objc private func loadButtonTapped() {
        listActive?(ReadActiveViewModel(codes: ["PETR4", "MGLU3"]))
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
        
    }
}
