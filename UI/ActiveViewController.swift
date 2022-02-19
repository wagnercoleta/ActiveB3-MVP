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
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
