//
//  PhotoInfo.swift
//  SpacePhoto
//
//  Created by Sashko Shel on 8/4/19.
//  Copyright © 2019 Sashko Shel. All rights reserved.
//

import Foundation

struct PhotoInfo: Codable {
    var title: String
    var description: String
    var url: URL
    var copyright: String?
    //    var explanation: String
    
    enum CodingKeys: String, CodingKey {
        case title
        case description = "explanation" // в JSON ключ называется "explanation", в то время как переменная в структуре называется по другому; именно для этого нужна эта энумерация
        case url
        case copyright
    }
    //
    //    init(from decoder: Decoder) {
    //
    //    }
}
