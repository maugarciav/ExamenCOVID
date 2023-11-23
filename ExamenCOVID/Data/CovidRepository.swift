//
//  CovidRepository.swift
//  ExamenCOVID
//
//  Created by Mauricio Garcia Villanueva on 23/11/23.
//

import Foundation

/// URL base, usamos la con la utlima actualizacion
struct Api {
    static let base = "https://api.api-ninjas.com/v1/covid19?date=2023-03-01"
}


protocol CovidAPIProtocol {
    func getCovidList() async -> [CovidData]?
}

/// Se implementa el protocolo 'CovidAPIProtocol' y utiliza el servicio de red para obtener datos de COVID.
class CovidRepository: CovidAPIProtocol {
    let nservice: NetworkApiService
    static let shared = CovidRepository()
    
    init(nservice: NetworkApiService = NetworkApiService.shared) {
        self.nservice = nservice
    }

    /// Función asincrónica que obtiene la lista de datos de COVID
    func getCovidList() async -> [CovidData]? {
        return await nservice.getCovidList(url: URL(string: "\(Api.base)")!)
    }
}

