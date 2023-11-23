//
//  CovidListRequirement.swift
//  ExamenCOVID
//
//  Created by Mauricio Garcia Villanueva on 23/11/23.
//



import Foundation


protocol CovidListRequirementProtocol {
    func getCovidList() async -> [CovidData]?
}


struct CovidListRequirement: CovidListRequirementProtocol {
    let covidRepository: CovidAPIProtocol
    static let shared = CovidListRequirement()
    
    
    init(covidRepository: CovidAPIProtocol = CovidRepository()) {
        self.covidRepository = covidRepository
    }
    
    
    func getCovidList() async -> [CovidData]? {
        return await covidRepository.getCovidList()
    }
}
