//
//  ModelCovid.swift
//  ExamenCOVID
//
//  Created by Mauricio Garcia Villanueva on 23/11/23.
//

import Foundation

/// Estructura de lo que nos regresa el API
struct CovidData: Codable {
    var country: String
    var region: String
    var cases: Cases
}

struct Cases: Codable {
    var total: Int
    var new: Int
}


struct Data: Codable {
    let results: [CovidData]
}

