//
//  TypeEraseQiitaRequest.swift
//  SwiftTypeEraseSample
//
//  Created by Takahiro Nishinobu on 2017/11/14.
//  Copyright © 2017年 hachinobu. All rights reserved.
//

import Foundation
import APIKit

struct TypeEraseQiitaRequest<ResponseType>: QiitaRequest {
    
    typealias Response = ResponseType
    
    var path: String
    var queryParameters: [String : Any]?
    var method: HTTPMethod
    var dataParser: DataParser
    private let responseHandler: ((Any, HTTPURLResponse) throws -> ResponseType)
    
    init<R: QiitaRequest>(request: R) where R.Response == ResponseType {
        self.path = request.path
        self.queryParameters = request.queryParameters
        self.method = request.method
        self.dataParser = request.dataParser
        self.responseHandler = request.response
    }
    
    func response(from object: Any, urlResponse: HTTPURLResponse) throws -> ResponseType {
        return try responseHandler(object, urlResponse)
    }
    
}
