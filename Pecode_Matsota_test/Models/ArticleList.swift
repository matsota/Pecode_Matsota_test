//
//  TopHeadlinesList.swift
//  Pecode_Matsota_test
//
//  Created by Andrew Matsota on 27.11.2020.
//

import UIKit

struct ArticleList: Codable {
    
    let totalResults: Int
    let articles: [Article]
    
    struct Article: Codable {
        let url: String?
        let title: String?
        let author: String?
        let content: String?
        let urlToImage: String?
        let description: String?
        let publishedAt: String?
        let source: HeadlineSource?
        
        public func descriptionSize(_ maxWidth: CGFloat, _ ofSize: CGFloat = 10,
                                    _ weight: UIFont.Weight = .regular) -> CGSize? {
            guard let text = description else {return nil}
            return estimateSize(of: text, maxWidth, ofSize, weight)
        }
        
        public func titleSize(_ maxWidth: CGFloat, _ ofSize: CGFloat = 10,
                              _ weight: UIFont.Weight = .regular) -> CGSize? {
            guard let text = title else {return nil}
            return estimateSize(of: text, maxWidth, ofSize, weight)
        }
        
        
        private func estimateSize(of text: String, _ maxWidth: CGFloat,
                                  _ ofSize: CGFloat, _ weight: UIFont.Weight) -> CGSize {
            let attributes: [NSAttributedString.Key: Any] =
                [.font: UIFont.systemFont(ofSize: ofSize, weight: weight)]
            
            let attributedText = NSAttributedString(string: text, attributes: attributes)
            
            let constraintBox = CGSize(width: maxWidth, height: .greatestFiniteMagnitude)
            
            let rect = attributedText.boundingRect(with: constraintBox,
                                                   options: [.usesLineFragmentOrigin, .usesFontLeading],
                                                   context: nil).integral
            return rect.size
        }
    }
    
}
