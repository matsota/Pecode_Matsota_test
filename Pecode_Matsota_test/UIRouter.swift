//
//  UIRouter.swift
//  Pecode_Matsota_test
//
//  Created by Andrew Matsota on 27.11.2020.
//

import UIKit

class UIRouter {
    
    //MARK: - Implementation
    public static var instance: UIRouter!
    public var window: UIWindow!
    
//    public func artileViewController() {
//        if let scene = UIApplication.shared.connectedScenes.first,
//           let windowScene = (scene as? UIWindowScene),
//           let window = UIRouter.instance.window {
//            let storyboard = UIStoryboard(name: "Article", bundle: nil)
//            let vc = ArticleViewController.instantiate(from: storyboard)
//            let navigationController = UINavigationController(rootViewController: vc)
//            navigationController.navigationBar.prefersLargeTitles = true
//            window.windowScene = windowScene
//            window.rootViewController = navigationController
//            window.makeKeyAndVisible()
//        }
//    }
    
    /// - `Scences`
    
    public lazy var articleScene: ArticleRouter = {
        return ArticleRouter(mainRouter: self)
    }()
    
    //MARK: - Init
    init(appDelegat :AppDelegate) {
        appDelegat.window = UIWindow(frame: UIScreen.main.bounds)
        window = appDelegat.window
        
        let storyboard = UIStoryboard(name: "Entry", bundle: nil)
        let vc = storyboard.instantiateInitialViewController()
        
        window.rootViewController = vc
        window.makeKeyAndVisible()
        
        UIRouter.instance = self
    }
    
    //MARK: - Private Implementation
    private let alertTitle = AlertTitles.self

}









//MARK: - Alerts
extension UIRouter {
    
    public func standartAlert(message: String, attributedMessage: NSAttributedString? = nil) {
        let alert = UIAlertController(title: "", message: message, preferredStyle: UIAlertController.Style.alert)
        if let attrString = attributedMessage {
            alert.setValue(attrString, forKey: "attributedMessage")
        }
        alert.addAction(UIAlertAction(title: alertTitle.confirm.rawValue, style: UIAlertAction.Style.default, handler: nil))
        topViewController?.present(alert, animated: true, completion: nil)
    }
    
}

//MARK: - Private Methods
private extension UIRouter {
    
    private var topViewController: UIViewController? {
        if var topController = UIApplication.shared.keyWindow?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            return topController
        }
        return nil
    }
    
}

enum AlertTitles: String {
    case confirm = "Confirm"
}
