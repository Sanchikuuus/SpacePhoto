//
//  URL+Helpers.swift
//  SpacePhoto
//
//  Created by Sashko Shel on 8/4/19.
//  Copyright © 2019 Sashko Shel. All rights reserved.
//

import Foundation

extension URL {
    func withQueries(_ queries: [String: String]) -> URL? {
        var components = URLComponents(url: self, resolvingAgainstBaseURL: true)
        components?.queryItems = queries.map { URLQueryItem(name: $0.0, value: $0.1) }
        return components?.url
    }
}
