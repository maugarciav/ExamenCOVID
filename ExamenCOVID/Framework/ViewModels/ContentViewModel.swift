//
//  ContentViewModel.swift
//  ExamenCOVID
//
//  Created by Mauricio Garcia Villanueva on 23/11/23.
//

import Foundation


class ContentViewModel : ObservableObject {
    @Published var covidList = [CovidData]()
    private var originalcovidList = [CovidData]()
    
    private var covidListRequirement: CovidListRequirement


    init(covidListRequirement: CovidListRequirement =  CovidListRequirement()){
        self.covidListRequirement = covidListRequirement
    }
    
    @MainActor
    func getCovidData () async {
        originalcovidList = await covidListRequirement.getCovidList() ?? []
        covidList = originalcovidList
    }
    
    func searchCountry(with searchText: String) {
        if searchText.isEmpty{
            covidList = originalcovidList
        }else{
        // Filtra la lista original de los paieses según el texto de búsqueda
            covidList = originalcovidList.filter { CovidData in
                return CovidData.country.lowercased().contains(searchText.lowercased())
            }
        }
    }

    
}
