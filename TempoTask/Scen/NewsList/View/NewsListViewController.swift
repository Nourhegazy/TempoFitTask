//
//  NewsListViewController.swift
//  TempoTask
//
//  Created by Nour Hegazy on 26/06/2021.
//

import UIKit

class NewsListViewController: BaseViewController<NewsListViewModel> {
    
    @IBOutlet weak var tvNews: UITableView!
    @IBOutlet weak var searchBare: UISearchBar!
    var searchActive : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBinding()
        setupTableView()
        self.viewModel.getNews()
    }
    
    func setupBinding() {
        self.viewModel.reloadTableView.asSignal().emit(onNext: { (arg0) in
            self.tvNews.reloadData()
        }).disposed(by: disposeBag)
        
    }
    
    func setupTableView() {
        tvNews.estimatedRowHeight = 140.0
        tvNews.rowHeight = UITableView.automaticDimension
        tvNews.tableFooterView = UIView()
        self.tvNews.keyboardDismissMode = .onDrag
        tvNews.register(UINib(nibName: "NewsListCell", bundle: nil), forCellReuseIdentifier: "NewsListCell")
    }
    
    func openNewsDetailsScreen(article : Article) {
        let newsDetailsViewModel = NewDetalisViewModel(article: article)
        let newsDetailsViewController = storyboard!.instantiateViewController(identifier: "NewsDetailsViewController")as? NewsDetailsViewController
        newsDetailsViewController?.viewModel = newsDetailsViewModel
        self.navigationController?.pushViewController(newsDetailsViewController!, animated: true)
    }
}

extension NewsListViewController : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchActive == true {
            return viewModel.arrFilter.count
        }else {
            return viewModel.news.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsListCell") as? NewsListCell
        let index  = searchActive ?self.viewModel.arrFilter[indexPath.row] : self.viewModel.news[indexPath.row]
        cell?.configCell(article: index)
        
        return cell ?? UITableViewCell()
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return  UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         let index =  searchActive ? self.viewModel.arrFilter[indexPath.row] :  self.viewModel.news[indexPath.row]
            self.openNewsDetailsScreen(article: index)
    }
    
}

extension NewsListViewController : UISearchBarDelegate {
   
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
           searchActive = true
       }

       func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
           searchActive = false
       }
    
//    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
//           searchActive = false;
//
//           searchBar.text = nil
//           searchBar.resignFirstResponder()
//           tvNews.resignFirstResponder()
//           tvNews.reloadData()
//       }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
           searchActive = false
       }

    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
                   return true
       }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.searchActive = true
        self.viewModel.arrFilter.removeAll()
        self.viewModel.arrFilter = searchText.isEmpty ? self.viewModel.news : self.viewModel.news.filter { $0.title!.lowercased().contains(searchText.lowercased()) }
       
        
        print("serch Count \(self.viewModel.arrFilter.count)")
        tvNews.reloadData()
        self.view.layoutSubviews()
    }
}
