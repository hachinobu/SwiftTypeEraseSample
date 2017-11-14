//
//  QiitaAPI.swift
//  SwiftTypeEraseSample
//
//  Created by Takahiro Nishinobu on 2017/11/14.
//  Copyright © 2017年 hachinobu. All rights reserved.
//

import Foundation
import APIKit

final class QiitaAPI {
    
    struct GetItemsRequest: QiitaRequest {
        
        typealias Response = [ItemEntity]
        
        var page: Int
        let perPage: Int
        
        init(page: Int = 1, perPage: Int = 20) {
            self.page = page
            self.perPage = perPage
        }
        
        var method: HTTPMethod {
            return .get
        }
        
        var path: String {
            return "/api/v2/items"
        }
        
        var queryParameters: [String : Any]? {
            return ["page": page.description, "per_page": perPage.description]
        }
        
    }
    
    struct GetUserItemsRequest: QiitaRequest {
        
        typealias Response = [ItemEntity]
        
        private let userId: String
        var page: Int
        let perPage: Int
        
        init(userId: String, page: Int = 1, perPage: Int = 20) {
            self.userId = userId
            self.page = page
            self.perPage = perPage
        }
        
        var method: HTTPMethod {
            return .get
        }
        
        var path: String {
            return "/api/v2/users/\(userId)/items"
        }
        
        var queryParameters: [String : Any]? {
            return ["page": page, "per_page": perPage]
        }
        
    }
    
}
