//
//  NetworkApiService.swift
//  ExamenCOVID
//
//  Created by Mauricio Garcia Villanueva on 23/11/23.
//

import Foundation
import Alamofire



class NetworkApiService {
    static let shared = NetworkApiService()


    func getCovidList(url: URL) async -> [CovidData]? {

        let headers: HTTPHeaders = [
            "X-Api-Key" : "Z6awhwtT3z0TQEpbcp3TYA==rxFp6snKUhuzfHAQ",
        ]
        
    
        let taskRequest = AF.request(url, method: .get, headers: headers).validate()
                let response = await taskRequest.serializingData().response
                
                switch response.result{
                case .success(let data):
                    do {
                        return try JSONDecoder().decode([CovidData].self, from: data)
                    } catch {
                        return nil
                    }
                case let .failure(error):
                    debugPrint(error.localizedDescription)
                    return nil
                }
    }
}

