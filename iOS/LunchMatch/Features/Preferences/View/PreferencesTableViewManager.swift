//
//  PreferencesTableViewManager.swift
//  LunchMatch
//
//  Created by Розалия Амирова on 07.11.2020.
//

import UIKit

class PreferencesTableViewManager: NSObject {
    
    private enum Constants {
        static let maxWidth: CGFloat = 330.0
        static let cellIndent: CGFloat = 22.0
        static let cellHeight: CGFloat = 231.0
        static let cellAspectRatio: CGFloat = 0.7
    }
    
    weak var tableView: UITableView? {
        didSet {
            setupTableView()
        }
    }
    
    var closedSections: [Int] = []
    
    let preferencesViewModelFactory = PreferencesViewModelFactory()
    
    private func setupTableView()  {
        guard let tableView = tableView else { return }
        
        tableView.register(UINib(resource: R.nib.preferencesTableViewHeader), forHeaderFooterViewReuseIdentifier: PreferencesTableViewHeader.reuseIdentifier)
        tableView.register(UINib(resource: R.nib.preferencesTableViewCell), forCellReuseIdentifier: PreferencesTableViewCell.reuseIdentifier)

        tableView.delegate = self
        tableView.dataSource = self
    }
}



// MARK: - UITableViewDataSource

extension PreferencesTableViewManager: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50.0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return getViewModel().sections.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return getViewModel().sections[section].cells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PreferencesTableViewCell.reuseIdentifier) as! PreferencesTableViewCell
        cell.configure(with: getViewModel().sections[indexPath.section].cells[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: PreferencesTableViewHeader.reuseIdentifier) as! PreferencesTableViewHeader
        header.configure(with: getViewModel().sections[section].header)
        return header
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        preferencesViewModelFactory.selectCell(at: indexPath)
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        preferencesViewModelFactory.selectCell(at: indexPath)
        tableView.reloadData()
    }
    
    private func getCounter(_ cells: [PreferencesTableViewCellViewModel]) -> String {
        let selected = cells.filter { $0.isSelected }.count
        return "\(selected)\\\(cells.count)"
    }
    
    private func getViewModel() -> PreferencesViewModel {
        return preferencesViewModelFactory.getPreferences()
    }
}




// MARK: - UITableViewDelegate

extension PreferencesTableViewManager: UITableViewDelegate {
    
}
