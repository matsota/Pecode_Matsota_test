//
//  ArticleTableViewCell.swift
//  Pecode_Matsota_test
//
//  Created by Andrew Matsota on 27.11.2020.
//

import UIKit

class ArticleTableViewCell: UITableViewCell {

    //MARK: Implementation
    static let identifier = "ArticleTableViewCell"
    static func nib() -> UINib {
        return UINib(nibName: ArticleTableViewCell.identifier, bundle: nil)
    }
    
    public func populate(_ model: ArticleList.Article) {
        self.model = model
        model.author != nil ? (authorLabel.text = model.author) :
            (authorLabel.text = "No Attribution")
        
        model.description != nil ? (textView.text = model.description) :
            (textView.text = "No Description")
        
        model.source?.name != nil ? (sourceLabel.text = model.source?.name) :
            (sourceLabel.text = "No Publisher")
        
        switch model.urlToImage {
        case .some(let urlString):
            guard let url = URL(string: urlString) else {return}
            request = articleImageView.download(from: url)
            
        default: break
        }
    }
    
    //MARK: - Override
    override func layoutSubviews() {
        super.layoutSubviews()
        
        guard let model = model else {return}
        let width = articleImageView.frame.width
        guard let frame = model.descriptionSize(width * 0.5) else {return}
        textViewHeightConstraint.constant = frame.height + 20
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        textViewHeightConstraint.constant = 100
        articleImageView.image = nil
        request?.cancel()
        request = nil
        model = nil
    }
    
    //MARK: - Private Implementation
    private var request: URLSessionTask?
    private var model: ArticleList.Article?
    
    private let view: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 10
        view.backgroundColor = .clear
        return view
    }()
    
    /// - `ImageView`
    @IBOutlet private weak var articleImageView: UIImageView!
    
    /// - `TextView`
    @IBOutlet private weak var textView: DescriptionTextVIew!
    
    /// - `Label`
    @IBOutlet private weak var sourceLabel: SmallTitleLabel!
    @IBOutlet private weak var authorLabel: SmallTitleLabel!
    
    /// - `Constraint`
    @IBOutlet private weak var textViewHeightConstraint: NSLayoutConstraint!
}
