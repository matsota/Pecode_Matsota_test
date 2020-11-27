//
//  ArticleRouter.swift
//  Pecode_Matsota_test
//
//  Created by Andrew Matsota on 27.11.2020.
//

import UIKit

final class ArticleRouter {
    
    //MARK: - Methods
    public func enter() {
        if let scene = UIApplication.shared.connectedScenes.first,
           let windowScene = (scene as? UIWindowScene),
           let window = UIRouter.instance.window {
            let vc = UIRouter.instance.articleScene.viewController()
            let navigationController = UINavigationController(rootViewController: vc)
            navigationController.navigationBar.prefersLargeTitles = false
            navigationController.navigationBar.tintColor = .black
            window.windowScene = windowScene
            window.rootViewController = navigationController
            window.makeKeyAndVisible()
        }
    }
    
    public func showMoreInformation(from parent: UIViewController, _ url: URL) {
        let vc = WebViewViewController.instantiate(from: storyboard)
        vc.url = url
        parent.navigationController?.navigationBar.tintColor = .black
        parent.navigationController?.pushViewController(vc, animated: true)
    }
    
    public func showArticleSearcher(from parent: UIViewController, _ state: ArticleState) {
        let vc = ArticleViewController.instantiate(from: storyboard)
        vc.vcState = state
        parent.navigationController?.navigationBar.tintColor = .black
        parent.navigationController?.pushViewController(vc, animated: true)
    }
    
    //MARK: - Init
    init (mainRouter: UIRouter) {
        self.mainRouter = mainRouter
        storyboard = UIStoryboard(name: "Article", bundle: nil)
    }
    
    //MARK: - Private Implementation
    private let storyboard: UIStoryboard!
    private weak var mainRouter: UIRouter!
}









//MARK: - Private Methods
private extension ArticleRouter {
    
    func viewController() -> ArticleViewController {
        let vc = ArticleViewController.instantiate(from: storyboard)
        return vc
    }
    
}
