//
//  Labels.swift
//  Pecode_Matsota_test
//
//  Created by Andrew Matsota on 27.11.2020.
//

import UIKit

class EntryLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupAppearance()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupAppearance()
    }
    
    private func setupAppearance() {
        self.numberOfLines = 0
        self.textColor = .lightText
        self.textAlignment = .center
        self.minimumScaleFactor = 0.6
        self.adjustsFontSizeToFitWidth = true
        self.font = UIFont.systemFont(ofSize: 50, weight: .heavy)
    }
    
}

class SmallPreTitleLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupAppearance()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupAppearance()
    }
    
    private func setupAppearance() {
        self.numberOfLines = 0
        self.textColor = .lightGray
        self.textAlignment = .center
        self.minimumScaleFactor = 0.6
        self.adjustsFontSizeToFitWidth = true
        self.font = UIFont.systemFont(ofSize: 12, weight: .thin)
    }
    
}

class SmallTitleLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupAppearance()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupAppearance()
    }
    
    private func setupAppearance() {
        self.numberOfLines = 0
        self.textColor = .black
        self.textAlignment = .center
        self.minimumScaleFactor = 0.6
        self.adjustsFontSizeToFitWidth = true
        self.font = UIFont.systemFont(ofSize: 15, weight: .thin)
    }
    
}

class BigTitleLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupAppearance()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupAppearance()
    }
    
    private func setupAppearance() {
        self.numberOfLines = 0
        self.textColor = .black
        self.textAlignment = .center
        self.minimumScaleFactor = 0.6
        self.adjustsFontSizeToFitWidth = true
        self.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
    }
    
}
