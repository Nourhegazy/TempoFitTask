//
//  DateFromate.swift
//  TempoTask
//
//  Created by Nour Hegazy on 26/06/2021.
//

import Foundation
extension String {
    func dateformat() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.init(identifier: "en")
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from: self)
        dateFormatter.dateFormat = "dd-M-yyyy"
        let dateString = dateFormatter.string(from: date ?? Date.init())
        return dateString
        
    }
    
}
