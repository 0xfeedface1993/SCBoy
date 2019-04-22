//
//  Api.swift
//  SCBoy
//
//  Created by virus1994 on 2019/4/22.
//  Copyright © 2019 ascp. All rights reserved.
//

import Foundation
import SwiftyJSON

typealias APICompletion = (Data?, URLResponse?, Error?) -> Void

enum APIError: Error {
    case emptyData
    case invalidJSON
}

struct APIHostURL {
    var url : URL
    static let mainHost = "http://aligulac.com/api/v1"
    static let johnHost = "http://aligulac.com/api/v1"
    static let recentMatch = APIHostURL(url: URL(string: "\(APIHostURL.mainHost)/match")!)
}

let APIKey = "iyyM8gyFkyyKUyNr206q"

protocol Api {
    
}

extension Api {
    func api(url: URL, params: [String:Any], completion: @escaping APICompletion) {
        var values = params
        values["apikey"] = APIKey
        let suffix = values.map({ "\($0.key)=\($0.value)" }).joined(separator: "&")
        let fullURL = url.absoluteString + "?" + suffix
        
        guard let completeURL = URL(string: fullURL) else {
            print("****** invalid url: \(fullURL)")
            return
        }
        
        let session = URLSession.shared
        var request = URLRequest(url: completeURL)
        request.httpMethod = "GET"
        
        let task = session.dataTask(with: request) { (data, response, networkError) in
            if let e = networkError {
                print("****** network error:\(e.localizedDescription)")
                completion(nil, response, e)
                return
            }
            
            guard let data = data else {
                print("****** Empty Data")
                completion(nil, response, APIError.emptyData)
                return
            }
            
            completion(data, response, nil)
        }
        
        task.resume()
    }
}


func convert(jsonData: Data) -> JSON? {
    do {
        let json = try JSON(data: jsonData)
        print(json)
        return json
    }   catch {
        print(error)
        return nil
    }
}
