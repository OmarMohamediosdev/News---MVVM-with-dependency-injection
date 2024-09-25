//
//  NetworkManager.swift
//  News
//
//  Created by Omar Mohamed on 29/12/2023.
//

import Foundation
import Alamofire

protocol HeadlineNewsProtocol {
    func getNewsHeadlines(completion: @escaping (_ error: Error?, _ headlines: Headlines?) -> Void)
}

class NetworkManager: HeadlineNewsProtocol {
    let url = "https://newsapi.org/v2/top-headlines?country=us&apiKey=881cdf9b06e54d3db71511c707bd9e93"
        
    func getNewsHeadlines(completion: @escaping (_ error: Error?, _ headlines: Headlines?) -> Void) {
        AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON { response in
            switch response.result {
            case .success(_):
                guard let data = response.data else {return}
                let decoder = JSONDecoder()
                do {
                    let response = try decoder.decode(Headlines.self, from: data)
                    print("response: ", response)
                    completion(nil, response)
                } catch {
                    print(error.localizedDescription)
                }
                
            case .failure(let error):
                completion(error, nil)
            }
        }
    }
}
