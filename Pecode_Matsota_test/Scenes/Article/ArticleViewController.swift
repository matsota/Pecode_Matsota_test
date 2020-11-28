//
//  ArticleViewController.swift
//  Pecode_Matsota_test
//
//  Created by Andrew Matsota on 27.11.2020.
//

import UIKit

enum ArticleState {
    case topHeadlines
    case browsing
}

class ArticleViewController: UIViewController, Storyboarding {
    
    //MARK: - Implementaion
    public var vcState: ArticleState = .topHeadlines
    
    //MARK: - Override
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /// - Setup
        navigationController()
        setupTableView()
        setupNetwork()
        
        let page = UserDefaults.standard.integer(forKey: UserDefaults.Key.currentPageOfTopHeadlines)
        populate(from: page, for: .us)
        
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
           refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
           tableView.addSubview(refreshControl) // not required when using UITableViewController
    }
    
    //MARK: - Private Implementation
    private var currentCountryState: CountriesIncluded = .us
    private var refreshControl = UIRefreshControl()
    private var articles = [ArticleList.Article]()
    private var networkManager: NetworkProtocol?
    private var totalTopHeadlineResults = Int()
    private var totalSearchesResults = Int()
    private var searchText: String?
    
    /// - `TableView`
    @IBOutlet private weak var tableView: UITableView!
}









//MARK: - UISearchResultsUpdating
extension ArticleViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text?.trimmingCharacters(in: .whitespacesAndNewlines),
              text != "" else {return}
        self.searchText = text
        searchBar.text = nil
        let params = ArticleRequestParameters(.everything, page: 1, text)
        dowloadArticles(params)
    }
    
}

//MARK: - Tablew View
extension ArticleViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    /// - `heightForHeaderInSection`
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return articles[section].titleSize(view.frame.width - 20, 20, .semibold)?.height ?? 44
    }
    
    /// - `viewForHeaderInSection`
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let size = articles[section].titleSize(view.frame.width - 20, 20, .semibold) ?? CGSize(width: view.frame.width, height: 44)
        
        let headerView = UIView()
        let label = UILabel()
        label.frame = CGRect(x: 10, y: 0, width: size.width, height: size.height)
        label.numberOfLines = 0
        label.textColor = .black
        label.textAlignment = .left
        label.backgroundColor = .clear
        label.text = articles[section].title
        label.isUserInteractionEnabled = true
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        
        headerView.addSubview(label)
        headerView.backgroundColor = .white
        headerView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: size.height)
        
        return headerView
    }
    
    /// - `numberOfSections`
    func numberOfSections(in tableView: UITableView) -> Int {
        return articles.count
    }
    
    /// - `numberOfRowsInSection`
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    /// - `cellForRowAt`
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ArticleTableViewCell.identifier, for: indexPath) as! ArticleTableViewCell
        
        let model = articles[indexPath.section]
        moreArticlesTrigger(indexPath)
        cell.populate(model)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let string = articles[indexPath.section].url,
              let url = URL(string: string) else {return}
        UIRouter.instance.articleScene.showMoreInformation(from: self, url)
    }
    
}

//MARK: - Private Setup
private extension ArticleViewController {
    
    func navigationController() {
        switch vcState {
        case .topHeadlines:
            let magnifierImage = UIImage(named: "magnifier")
            let magnifierButton = UIBarButtonItem(image: magnifierImage, style: .plain, target: self, action: #selector(magnifierAction(_:)))
            navigationItem.rightBarButtonItem = magnifierButton
            
            let usButton = UIBarButtonItem(title: "us", style: .plain, target: self, action: #selector(usAction(_:)))
            
            let uaButton = UIBarButtonItem(title: "ua", style: .plain, target: self, action: #selector(uaAction(_:)))
            
            navigationItem.leftBarButtonItems = [usButton, uaButton ]
            
        default:
            break
        }
    }
    
    func setupTableView() {
        tableView.register(ArticleTableViewCell.nib(), forCellReuseIdentifier: ArticleTableViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.keyboardDismissMode = .onDrag
    }
    
    func setupNetwork() {
        let networking = NetworkService()
        networkManager = NetworkManager(networking: networking)
        
        switch vcState {
        case .topHeadlines:
            NotificationCenter.default.addObserver(self, selector: #selector(loadMoreArticles(_:)), name: .loadMoreTopArticles, object: nil)
            
        case .browsing:
            NotificationCenter.default.addObserver(self, selector: #selector(loadMoreArticles(_:)), name: .loadMoreSearchingArticles, object: nil)
        }
    }
    
}

//MARK: - Private Methods
private extension ArticleViewController {
    
    @objc func refresh(_ sender: AnyObject) {
        switch self.vcState {
        case .topHeadlines:
            UserDefaults.standard.set(1, forKey: UserDefaults.Key.currentPageOfTopHeadlines)
            let params = ArticleRequestParameters(.top_headlines, page: 1, currentCountryState)
            dowloadArticles(params)
            
        case .browsing:
            UserDefaults.standard.set(1, forKey: UserDefaults.Key.currentPageOfTopHeadlines)
            let params = ArticleRequestParameters(.everything, page: 1, searchText)
            dowloadArticles(params)
        }
    }
    
    @objc func magnifierAction(_ sender: UIBarButtonItem) {
        UIRouter.instance.articleScene.showArticleSearcher(from: self, .browsing)
    }
    
    @objc func usAction(_ sender: UIBarButtonItem) {
        UserDefaults.standard.set(1, forKey: UserDefaults.Key.currentPageOfTopHeadlines)
        currentCountryState = .us
        populate(from: 1, for: .us)
    }
    
    @objc func uaAction(_ sender: UIBarButtonItem) {
        UserDefaults.standard.set(1, forKey: UserDefaults.Key.currentPageOfTopHeadlines)
        currentCountryState = .ua
        populate(from: 1, for: .ua)
    }
    
    func dowloadArticles(_ params: ArticleRequestParameters) {
        networkManager?.readAvailableArticles(params, success: { (data, totalResults)  in
            switch self.vcState {
            case .topHeadlines:
                self.totalTopHeadlineResults = totalResults
                
            case .browsing:
                self.totalSearchesResults = totalResults
            }
            
            switch params.page {
            case 1:
                self.articles = data
            case 1...5:
                self.articles.append(contentsOf: data)
            default: break
            }
            
            self.tableView.reloadData()
            self.refreshControl.endRefreshing()
        }, failure: { (localizedDescription) in
            debugPrint("ERROR:", localizedDescription)
            self.refreshControl.endRefreshing()
        })
    }
    
    func populate(from page: Int, for country: CountriesIncluded) {
        switch page {
        case 0...5:
            switch vcState {
            case .topHeadlines:
                let params = ArticleRequestParameters(.top_headlines, page: page, country)
                dowloadArticles(params)
                
            case .browsing:
                let searchBar = UISearchBar()
                searchBar.sizeToFit()
                searchBar.placeholder = "Search article"
                searchBar.delegate = self
                navigationItem.titleView = searchBar
                searchBar.becomeFirstResponder()
            }
            
        default: break
        }
    }
    
    func moreArticlesTrigger(_ indexPath: IndexPath) {
        if indexPath.section == articles.count / 2 {
            switch vcState {
            case .topHeadlines:
                if totalTopHeadlineResults > articles.count {
                    NotificationCenter.default.post(Notification(name: .loadMoreTopArticles))
                }
                
            case .browsing:
                if totalSearchesResults > articles.count {
                    NotificationCenter.default.post(Notification(name: .loadMoreSearchingArticles))
                }
            }
        }
    }
    
    @objc func loadMoreArticles(_ notification: Notification) {
        switch vcState {
        case .topHeadlines:
            let page = UserDefaults.standard.integer(forKey: UserDefaults.Key.currentPageOfTopHeadlines)
            UserDefaults.standard.set(page + 1, forKey: UserDefaults.Key.currentPageOfTopHeadlines)
            let params = ArticleRequestParameters(.top_headlines, page: page + 1, .us)
            dowloadArticles(params)
            
        case .browsing:
            guard let text = searchText else {return}
            let page = UserDefaults.standard.integer(forKey: UserDefaults.Key.currentPageOfSearchHeadlines)
            UserDefaults.standard.set(page + 1, forKey: UserDefaults.Key.currentPageOfSearchHeadlines)
            let params = ArticleRequestParameters(.everything, page: page + 1, text)
            dowloadArticles(params)
        }
    }
    
}
