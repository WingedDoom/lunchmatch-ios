//
//  XibInitializable.swift
//  LunchMatch
//
//  Created by Булат Хабиров on 06.11.2020.
//

import UIKit

public protocol XibInitializable {}

extension XibInitializable where Self: UIView {
    public func xibSetup() {
        let xibContainer = loadViewFromNib()
        xibContainer.frame = bounds
        xibContainer.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(xibContainer)
        
        backgroundColor = xibContainer.backgroundColor
        xibContainer.backgroundColor = .clear
    }
    
    private func loadViewFromNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        
        return view
    }
}
