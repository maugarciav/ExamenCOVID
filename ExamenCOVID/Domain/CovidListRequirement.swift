//
//  CovidListRequirement.swift
//  ExamenCOVID
//
//  Created by Mauricio Garcia Villanueva on 23/11/23.
//



import Foundation

/// Protocolo que define los requisitos para obtener la lista de datos de COVID.
protocol CovidListRequirementProtocol {
    func getCovidList() async -> [CovidData]?
}


///Implementación del protocolo que utiliza un repositorio de API de COVID.
struct CovidListRequirement: CovidListRequirementProtocol {
    let covidRepository: CovidAPIProtocol
    static let shared = CovidListRequirement()
    
    
    init(covidRepository: CovidAPIProtocol = CovidRepository()) {
        self.covidRepository = covidRepository
    }
    
    /// Función asincrónica que obtiene la lista de datos de COVID utilizando el repositorio.
    func getCovidList() async -> [CovidData]? {
        return await covidRepository.getCovidList()
    }
}
