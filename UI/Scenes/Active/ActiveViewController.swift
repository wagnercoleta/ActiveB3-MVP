//
//  ActiveViewController.swift
//  UI
//
//  Created by Wagner Coleta on 19/02/22.
//

import Foundation
import UIKit
import Presentation
import Domain

final class ActiveViewController: UIViewController {
    
    @IBOutlet weak var loadingIncator: UIActivityIndicatorView!
    @IBOutlet weak var loadButton: UIButton!
    @IBOutlet weak var codeActiveTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    var activeMethod: ((ReadActiveViewModel) -> Void)?
    
    private var actives = [ActiveModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    private func configure() {
        loadButton?.layer.cornerRadius = 5
        loadButton?.addTarget(self, action: #selector(loadButtonTapped), for: .touchUpInside)
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.dataSource = self
    }
    
    @objc private func loadButtonTapped() {
        if let codeActive = codeActiveTextField?.text {
            var codes = [String]()
            codes.append(codeActive)
            activeMethod?(ReadActiveViewModel(codes: codes))
        }
    }
}

extension ActiveViewController: LoadingView {
    func display(viewModel: LoadingViewModel) {
        if viewModel.isLoading {
            view.isUserInteractionEnabled = false // Desabilita todas interações do usuário
            loadingIncator?.startAnimating()
        } else {
            view.isUserInteractionEnabled = true // Habilita todas interações do usuário
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

extension ActiveViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return actives.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let codeActive = actives[indexPath.row].code
        cell.textLabel?.text = codeActive
        return cell
    }
}
