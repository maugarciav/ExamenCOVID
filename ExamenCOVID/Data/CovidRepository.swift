//
//  CovidRepository.swift
//  ExamenCOVID
//
//  Created by Mauricio Garcia Villanueva on 23/11/23.
//

import Foundation



struct Api {
    static let base = "https://api.api-ninjas.com/v1/covid19?date=2022-01-01"
}


protocol CovidAPIProtocol {
    func getCovidList() async -> [CovidData]?
}


class CovidRepository: CovidAPIProtocol {
    let nservice: NetworkApiService
    static let shared = CovidRepository()

    
    
    init(nservice: NetworkApiService = NetworkApiService.shared) {
        self.nservice = nservice
    }


    func getCovidList() async -> [CovidData]? {
        return await nservice.getCovidList(url: URL(string:"\(Api.base)")!)
    }
}
