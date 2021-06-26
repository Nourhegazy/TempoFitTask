//
//  File.swift
//  TempoTask
//
//  Created by Nour Hegazy on 26/06/2021.
//

import Foundation
import Moya

enum NewsApi {   
    case getAllNews
}

extension NewsApi : TargetType  {
    
    private var requestURL: URL {
        return (URL(string: APIConstants.BaseURL))!
    }
    
    var baseURL: URL {
        return requestURL
    }
    
    var path: String {
        switch self {
        case .getAllNews:
            return APIConstants.URLpath.news
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var sampleData: Data {
        return "".data(using: .utf8)!
    }
    
    var task: Task {
        
        switch self {
        case .getAllNews :
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return nil
        }
        
    }
    
