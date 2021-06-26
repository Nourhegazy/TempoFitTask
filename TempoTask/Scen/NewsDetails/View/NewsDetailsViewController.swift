//
//  NewsDetailsViewController.swift
//  TempoTask
//
//  Created by Nour Hegazy on 26/06/2021.
//

import UIKit
import Kingfisher

class NewsDetailsViewController: BaseViewController<NewDetalisViewModel> {

    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var imageNews: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblSourceName: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblAuthor: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        BindingData()
        bindDataToNewDetailsView(article: self.viewModel.article)
    }
    
    func BindingData()  {
        btnBack.rx.tap.bind {
            self.navigationController?.popViewController(animated: true)
        }.disposed(by: disposeBag)
    }
    
    func bindDataToNewDetailsView(article : Article ) {
        lblTitle.text = article.title ?? ""
        lblDescription.text = article.articleDescription
        lblSourceName.text = article.source?.name ?? ""
        lblAuthor.text = article.author ?? ""
        if  let url = URL(string: article.urlToImage ?? "") {
            imageNews.kf.setImage(with: url)
        }
        lblDate.text = article.publishedAt?.dateformat()
        
      
    }

}


