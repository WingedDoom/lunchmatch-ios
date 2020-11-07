//
//  PreferencesView.swift
//  LunchMatch
//
//  Created by Розалия Амирова on 07.11.2020.
//

import UIKit

class PreferencesView: UIView {
    private lazy var tableView: UITableView = UITableView()
    private let manager = PreferencesTableViewManager()
    
    private let button = SelectableButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        didLoad()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        didLoad()
    }
    
    private func didLoad() {
        addSubview(tableView)
        addSubview(button)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15.0),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15.0)
        ])
        
        NSLayoutConstraint.activate([
            button.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -60.0),
            button.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 65.0),
            button.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -65.0)
        ])

        button.title = "Next"
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false
        
        manager.tableView = tableView
        tableView.backgroundColor = UIColor.white
        tableView.tableFooterView = UIView()
    }
    
    func configure(with viewModel: PreferencesViewModel) {
//        manager.viewModel = viewModel
    }
}
