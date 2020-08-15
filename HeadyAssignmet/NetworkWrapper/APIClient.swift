//
//  APIClient.swift
//  HeadyAssignmet
//
//  Created by Sandeep on 8/12/20.
//  Copyright © 2020 Sandeep. All rights reserved.
//

import Foundation
import RealmSwift

enum HTTPMETHOD : String {
    case GET
    case POST
    case PUT
    case DELETE
}

struct Contants {
    struct Url {
        static let categories = "https://stark-spire-93433.herokuapp.com/json"
    }
}

class APIClient
{
    static let sharedInstance = APIClient()
    
    func performAPIRequest<T:Decodable>(_ urlSchema:String?, methodType:HTTPMETHOD, parameters:[String:AnyObject]?,completionHandler:@escaping (Result<T, Error>) -> ()) {
        let url:NSURL = NSURL(string:urlSchema!)!

        let request = NSMutableURLRequest(url: url as URL)
        request.httpMethod = methodType.rawValue
        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest) { (data, response, error) in
            guard error == nil else {
                completionHandler(.failure(error!))
                return
            }
            do {
                let categories = try JSONDecoder().decode(T.self, from: data!)
                completionHandler(.success(categories))
            } catch let finalError {
                completionHandler(.failure(finalError))
            }
        }
        task.resume()
    }
}
