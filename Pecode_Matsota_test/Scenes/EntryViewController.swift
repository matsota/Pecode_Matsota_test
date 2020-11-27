//
//  ViewController.swift
//  Pecode_Matsota_test
//
//  Created by Andrew Matsota on 27.11.2020.
//

import UIKit

class EntryViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            UIRouter.instance.articleScene.enter()
        }
    }

    //MARK: - Private Implementation
    
    /// - `Label`
    @IBOutlet private weak var entryLabel: EntryLabel!
}
