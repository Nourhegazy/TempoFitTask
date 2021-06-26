//
//  NewsListCell.swift
//  TempoTask
//
//  Created by Nour Hegazy on 26/06/2021.
//

import UIKit
import Kingfisher
class NewsListCell: UITableViewCell {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var imageNews: UIImageView!
    @IBOutlet weak var lblSourceName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        imageView?.layer.cornerRadius = 5
        
    }

    func configCell (article : Article) {
        if  let url = URL(string: article.urlToImage ?? "") {
            imageNews.kf.setImage(with: url)
        }
        lblTitle.text = article.title ?? ""
       
        lblSourceName.text = article.source?.name ?? ""
    }
    
}
