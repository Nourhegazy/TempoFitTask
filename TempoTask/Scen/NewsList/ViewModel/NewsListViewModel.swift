//
//  NewsListViewModel.swift
//  TempoTask
//
//  Created by Nour Hegazy on 26/06/2021.
//

import Foundation
import Moya
import RxCocoa
import RxSwift


class NewsListViewModel : BaseViewModel {
    var news = [Article]()
    var arrFilter = [Article]()
  
    var reloadTableView =  PublishRelay<Bool>()
    
    private let api : MoyaProvider<NewsApi>
    init( api :MoyaProvider<NewsApi> ) {
        self.api = api
    }
    
    func getNews() {
        self.isLoadingRequestRelay.accept(true)
        api.rx.request(.getAllNews)
            .map(NewsResponse.self
                 , atKeyPath: "", using: JSONDecoder(), failsOnEmptyData: false).subscribWithErrorHandling(onSuccess: { [weak self] myResponse in
            guard let self = self else {return}
            self.isLoadingRequestRelay.accept(false)
                if   let arr =  myResponse.articles {
                    self.news = arr
                  print("Count From Api Posts \(arr.count)")
                self.reloadTableView.accept(true)
                                                                                                                }
            
            }, onError: {  _ in
                self.isLoadingRequestRelay.accept(false)
        }, viewModel:self, errorMessageSize: .large).disposed(by: disposeBag)
    }
    
    
    
}
