//
//  SelecteableButton.swift
//  LunchMatch
//
//  Created by Розалия Амирова on 07.11.2020.
//

import UIKit

class SelectableButton: UIButton {
    
    func setSelected(_ selected: Bool) {
        selected ? select() : deselect()
    }
    
    func select() {
        backgroundColor = UIColor.green
        layer.cornerRadius = 10
        layer.borderWidth = 1
        layer.borderColor = UIColor.green.cgColor
        setTitleColor(UIColor.white, for: .normal)
        setTitle("Selected", for: .normal)
    }
    
    func deselect() {
        backgroundColor = .clear
        layer.cornerRadius = 10
        layer.borderWidth = 1
        layer.borderColor = UIColor.green.cgColor
        setTitleColor(UIColor.green, for: .normal)
        setTitle("Select", for: .normal)
    }
}
