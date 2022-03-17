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

public final class ActiveViewController: UIViewController, Storyboarded {
    
    @IBOutlet weak var loadingIncator: UIActivityIndicatorView!
    @IBOutlet weak var loadButton: UIButton!
    @IBOutlet weak var codeActiveTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    public var activeMethod: ((ReadActiveRequest) -> Void)?
    
    private var actives = [ActiveModel]()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    private func configure() {
        title = "Ativo B3"
        view.backgroundColor = Color.primary
        
        tableView.backgroundColor = Color.primary
        tableView.isScrollEnabled = false
        tableView.separatorStyle = .none
        tableView.showsHorizontalScrollIndicator = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(ActiveViewCell.self, forCellReuseIdentifier: "cell")
        
        tableView.dataSource = self
        tableView.delegate = self
        
        loadButton?.layer.cornerRadius = 5
        loadButton.setTitleColor(Color.font, for: .normal)
        loadButton?.addTarget(self, action: #selector(loadButtonTapped), for: .touchUpInside)
        
        codeActiveTextField.textColor = Color.secundary
        
        hideKeyboardOnTap()
        
        codeActiveTextField.text = "PETR4,MGLU3,USIM5,GGBR4,FESA4,GOLL4,VALE3,AZUL4"
    }
    
    @objc private func loadButtonTapped() {
        loadItens(activeModels: [ActiveModel]())
        if let codeActive = codeActiveTextField?.text {
            let codesArray = codeActive.components(separatedBy: ",")
            activeMethod?(ReadActiveRequest(codes: codesArray))
        }
    }
}

extension ActiveViewController: LoadingView {
    public func display(viewModel: LoadingViewModel) {
        if viewModel.isLoading {
            view.isUserInteractionEnabled = false // Desabilita todas interações do usuário
            loadButton.setTitle("", for: .normal)
            loadingIncator?.startAnimating()
        } else {
            view.isUserInteractionEnabled = true // Habilita todas interações do usuário
            loadButton.setTitle("Consultar", for: .normal)
            loadingIncator?.stopAnimating()
        }
    }
}

extension ActiveViewController: AlertView {
    public func showMessage(viewModel: AlertViewModel) {
        let alert = UIAlertController(title: viewModel.title, message: viewModel.message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        present(alert, animated: true)
    }
}

extension ActiveViewController: PresenterView {
    public func loadItens(activeModels: [ActiveModel]) {
        actives = activeModels
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

extension ActiveViewController: UITableViewDelegate, UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return actives.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ActiveViewCell
        let active = actives[indexPath.row]
        cell.setup(item: active)
        return cell
    }
}
