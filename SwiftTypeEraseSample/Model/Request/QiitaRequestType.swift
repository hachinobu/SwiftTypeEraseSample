//
//  QiitaRequestType.swift
//  SwiftTypeEraseSample
//
//  Created by Takahiro Nishinobu on 2017/11/14.
//  Copyright © 2017年 hachinobu. All rights reserved.
//

import Foundation
import APIKit

struct QiitaError: Error {
    let message: String
    
    init(object: AnyObject) {
        message = object["message"] as? String ?? "Unknown Error"
    }
}

protocol QiitaRequest: Request {
}

extension QiitaRequest {
    
    var baseURL: URL {
        return URL(string: "https://qiita.com")!
    }
    
    var dataParser: DataParser {
        return JSONDataParser(readingOptions: [])
    }
    
    func intercept(object: Any, urlResponse: HTTPURLResponse) throws -> Any {
        switch urlResponse.statusCode {
        case 200..<300:
            return object
        case 400, 401, 402, 403, 404:
            throw QiitaError(object: object as AnyObject)
        default:
            throw ResponseError.unacceptableStatusCode(urlResponse.statusCode)
        }
    }
    
}

extension QiitaRequest where Response: Codable, Response: Sequence, Response.Iterator.Element: Codable {
    
    var dataParser: DataParser {
        return CodableParser()
    }
    
    func response(from object: Any, urlResponse: HTTPURLResponse) throws -> Response {
        guard let data = object as? Data else {
            throw ResponseError.unexpectedObject(object)
        }
        let decoder = JSONDecoder()
        return try decoder.decode(Response.self, from: data)
    }
    
}

extension QiitaRequest where Response == Void {
    
    func response(from object: Any, urlResponse: HTTPURLResponse) throws -> Void {
        return ()
    }
    
}

class CodableParser: DataParser {
    
    public var contentType: String? {
        return "application/json"
    }
    
    public func parse(data: Data) throws -> Any {
        return data
    }
    
}
