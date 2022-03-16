//
//  ActiveViewCell.swift
//  UI
//
//  Created by Wagner Coleta on 15/03/22.
//

import Foundation
import UIKit
import Domain

public class ActiveViewCell: UITableViewCell {
    
    private struct Metrics {
        static let viewSpacing: CGFloat = 2.5
        static let cellSpacing: CGFloat = 10.0
        static let fontSize: CGFloat = 17.0
        static let subFontSize: CGFloat = 12.0
    }
    
    private var viewCell: UIView = {
        let view = UIView()
        view.backgroundColor = Color.secundary
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 10
        return view
    }()
    
    private var codeLabel: UILabel = {
        let label = UILabel()
        label.textColor = Color.font
        label.font = UIFont.boldSystemFont(ofSize: Metrics.fontSize)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = Color.font
        label.font = UIFont.systemFont(ofSize: Metrics.subFontSize)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var priceLabel: UILabel = {
        let label = UILabel()
        label.textColor = Color.font
        label.font = UIFont.boldSystemFont(ofSize: Metrics.fontSize)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var variationLabel: UILabel = {
        let label = UILabel()
        label.textColor = Color.font
        label.font = UIFont.systemFont(ofSize: Metrics.subFontSize)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private override init(style: UITableViewCell.CellStyle,
                          reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
        constraintUI()
    }
    
    public required init?(coder: NSCoder) {
        fatalError("not been implemented")
    }
    
    public func setup(item: ActiveModel) {
        codeLabel.text = item.code
        nameLabel.text = item.name
        priceLabel.text = getFormattedValue(of: item.price)
        variationLabel.text = "\(getFormattedValue(of: item.variation, hideCurrencySymbol: true))%"
        if (item.variation < 0)
        {
            variationLabel.textColor = .red
            variationLabel.alpha = 0.40
        } else if (item.variation > 0) {
            variationLabel.textColor = .green
            variationLabel.alpha = 0.40
        }
    }
    
    func getFormattedValue(of value: Double, hideCurrencySymbol: Bool = false) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencySymbol = hideCurrencySymbol ? "" : "R$ "
        formatter.alwaysShowsDecimalSeparator = true
        formatter.currencyDecimalSeparator = ","
        return formatter.string(for: value)!
    }
    
    private func setupCell() {
        contentView.backgroundColor = Color.primary
        selectionStyle = UITableViewCell.SelectionStyle.none
    }
    
    private func constraintUI() {
        contentView.addSubview(viewCell)
        viewCell.addSubview(codeLabel)
        viewCell.addSubview(nameLabel)
        viewCell.addSubview(priceLabel)
        viewCell.addSubview(variationLabel)
        
        NSLayoutConstraint.activate([
            viewCell.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0.0),
            viewCell.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Metrics.viewSpacing),
            viewCell.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0.0),
            viewCell.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Metrics.viewSpacing),
            
            codeLabel.leadingAnchor.constraint(equalTo: viewCell.leadingAnchor, constant: Metrics.cellSpacing),
            codeLabel.topAnchor.constraint(equalTo: viewCell.topAnchor, constant: Metrics.cellSpacing),
            
            nameLabel.leadingAnchor.constraint(equalTo: codeLabel.leadingAnchor, constant: 0.0),
            nameLabel.topAnchor.constraint(equalTo: codeLabel.bottomAnchor, constant: Metrics.cellSpacing),
            nameLabel.bottomAnchor.constraint(equalTo: viewCell.bottomAnchor, constant: -Metrics.cellSpacing),
            
            priceLabel.topAnchor.constraint(equalTo: viewCell.topAnchor, constant: Metrics.cellSpacing),
            priceLabel.trailingAnchor.constraint(equalTo: viewCell.trailingAnchor, constant: -Metrics.cellSpacing),
            
            variationLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: Metrics.cellSpacing),
            variationLabel.trailingAnchor.constraint(equalTo: viewCell.trailingAnchor, constant: -Metrics.cellSpacing)
        ])
    }
}
