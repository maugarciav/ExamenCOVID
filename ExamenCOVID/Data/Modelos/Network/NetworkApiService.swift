//
//  NetworkApiService.swift
//  ExamenCOVID
//
//  Created by Mauricio Garcia Villanueva on 23/11/23.
//

import Foundation
import Alamofire

/// Obtenemos los datos de COVID a través de una API.
class NetworkApiService {
    static let shared = NetworkApiService()

    /// Función asincrónica que obtiene la lista de datos de COVID desde una URL utilizando Alamofire.
    func getCovidList(url: URL) async -> [CovidData]? {

        //Token
        let headers: HTTPHeaders = [
            "X-Api-Key" : "Z6awhwtT3z0TQEpbcp3TYA==rxFp6snKUhuzfHAQ",
        ]
        
        let taskRequest = AF.request(url, method: .get, headers: headers).validate()
        

        let response = await taskRequest.serializingData().response
                
        switch response.result {
        case .success(let data):
            do {
                //Guardamos en array
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
