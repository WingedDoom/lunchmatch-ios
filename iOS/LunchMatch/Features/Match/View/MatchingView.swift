//
//  MatchingView.swift
//  LunchMatch
//
//  Created by Розалия Амирова on 07.11.2020.
//

import UIKit

class MatchingView: UIView, XibInitializable {
    @IBOutlet
    private weak var imageView: UIImageView!
    
    @IBOutlet
    private weak var title: UILabel! {
        didSet {
            title.font = .appTitle1
            title.text = R.string.localizable.matchingTitle()
        }
    }
    
    @IBOutlet weak var subtitle: UILabel! {
        didSet {
            subtitle.font = .appBody
            subtitle.text = R.string.localizable.matchingSubtitle()
        }
    }
    
    @IBOutlet
    private weak var tagsView: TagsView!
    
    var finishedUserNames: [String] = [] {
        didSet {
            tagsView.configure(with: finishedUserNames.map { .init(name: $0) })
        }
    }
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        didLoad()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        didLoad()
    }
    
    private func didLoad() {
        xibSetup()
        imageView.image = animation
        imageView.startAnimating()
    }
}

private extension MatchingView {
    var animation: UIImage? {
        UIImage.animatedImage(
            with: [
                R.image.winnie1()!,
                R.image.winnie2()!
            ],
            duration: 0.3
        )
    }
}
