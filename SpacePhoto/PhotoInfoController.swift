//
//  PhotoInfoController.swift
//  SpacePhoto
//
//  Created by Sashko Shel on 8/4/19.
//  Copyright © 2019 Sashko Shel. All rights reserved.
//

import Foundation

class PhotoInfoController {
    
    func fetchPhotoInfo(competion: @escaping (PhotoInfo?) -> Void) { //функция получения данных с кложуром для обработки полученного, если оно есть
        
        let baseURL = URL(string: "https://api.nasa.gov/planetary/apod")!
        
        let query = [
            "api_key": "DEMO_KEY"
            // "date": "2018-08-04"
        ]
        
        let url = baseURL.withQueries(query)!
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            let jsonDecoder = JSONDecoder()
            if let data = data, let photoDictionary = try? jsonDecoder.decode(PhotoInfo.self, from: data) {
                //        print(photoDictionary)
                //            print(photoDictionary.title)
                //            print(photoDictionary.url)
                //            print(photoDictionary.description)
                competion(photoDictionary)
            } else {
                competion(nil)
            }            
        }
        
        task.resume()
    }
    
}
