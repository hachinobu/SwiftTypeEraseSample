//
//  ItemEntity.swift
//  SwiftTypeEraseSample
//
//  Created by Takahiro Nishinobu on 2017/11/14.
//  Copyright © 2017年 hachinobu. All rights reserved.
//

import Foundation

struct ItemEntity: Codable {
    let id: String
    let title: String
    
    private enum CodingKeys: String, CodingKey {
        case id
        case title
    }
    
}
