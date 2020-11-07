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

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15.0),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15.0)
        ])
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        manager.tableView = tableView
        tableView.backgroundColor = UIColor.white
    }
    
    func configure(with viewModel: PreferencesViewModel) {
//        manager.viewModel = viewModel
    }
}
