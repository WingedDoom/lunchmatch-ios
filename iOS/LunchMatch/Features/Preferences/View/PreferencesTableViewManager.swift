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
        tableView.register(UINib(resource: R.nib.rangeTableViewCell), forCellReuseIdentifier: RangeTableViewCell.reuseIdentifier)

        tableView.delegate = self
        tableView.dataSource = self
    }
}



// MARK: - UITableViewDataSource

extension PreferencesTableViewManager: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 { return 150.0 }
        return 50.0
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 { return 0.0 }
        return 50.0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return getViewModel().sections.count + 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 { return 1 }
        return getViewModel().sections[section - 1].cells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: RangeTableViewCell.reuseIdentifier) as! RangeTableViewCell
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: PreferencesTableViewCell.reuseIdentifier) as! PreferencesTableViewCell
        cell.configure(with: getViewModel().sections[indexPath.section - 1].cells[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard section != 0 else { return nil }
        
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: PreferencesTableViewHeader.reuseIdentifier) as! PreferencesTableViewHeader
        header.configure(with: getViewModel().sections[section - 1].header)
        return header
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        preferencesViewModelFactory.selectCell(at: IndexPath(row: indexPath.row, section: indexPath.section - 1))
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        preferencesViewModelFactory.selectCell(at: IndexPath(row: indexPath.row, section: indexPath.section - 1))
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
