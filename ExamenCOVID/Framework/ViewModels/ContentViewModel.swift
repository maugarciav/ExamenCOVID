//
//  ContentViewModel.swift
//  ExamenCOVID
//
//  Created by Mauricio Garcia Villanueva on 23/11/23.
//

import Foundation



class ContentViewModel : ObservableObject {
    @Published var covidList = [CovidData]()
    
    private var covidListRequirement: CovidListRequirement


    init(covidListRequirement: CovidListRequirement =  CovidListRequirement()){
        self.covidListRequirement = covidListRequirement
    }
    
    @MainActor
    func getCovidData () async {
        covidList = await covidListRequirement.getCovidList() ?? []

    }
}
