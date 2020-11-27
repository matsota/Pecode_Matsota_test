//
//  Storyboarding.swift
//  Pecode_Matsota_test
//
//  Created by Andrew Matsota on 27.11.2020.
//

import UIKit

protocol Storyboarding { }

extension Storyboarding where Self: UIViewController {

    /// - `read` ViewController from some storyboard
    static func instantiate(from storyboard: UIStoryboard) -> Self {
        let storyboardIdentifier = String(describing: self)
        return storyboard.instantiateViewController(withIdentifier: storyboardIdentifier) as! Self
    }
    
}
