//
//  TextView.swift
//  Pecode_Matsota_test
//
//  Created by Andrew Matsota on 27.11.2020.
//

import UIKit

class DescriptionTextVIew: UITextView {
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupAppearance()
    }
    
    private func setupAppearance() {
        self.isEditable = false
        self.textColor = .black
        self.layer.cornerRadius = 10
        self.textAlignment = .center
        self.isScrollEnabled = false
        self.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.white.withAlphaComponent(0.25).cgColor
        self.font = UIFont.systemFont(ofSize: 10, weight: .thin)
    }
    
}
