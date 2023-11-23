//
//  ContentViewModel.swift
//  ExamenCOVID
//
//  Created by Mauricio Garcia Villanueva on 23/11/23.
//

import Foundation

/// ViewModel se encarga de la  lógica de la vista
class ContentViewModel: ObservableObject {
    // Lista de datos de COVID
    @Published var covidList = [CovidData]()
    private var originalCovidList = [CovidData]() //creamos una lista copia para el searchbar
    

    var covidListRequirement: CovidListRequirement
    init(covidListRequirement: CovidListRequirement =  CovidListRequirement()){
        self.covidListRequirement = covidListRequirement
    }
    

    @MainActor
    func getCovidData () async {
        originalCovidList = await covidListRequirement.getCovidList() ?? []
        covidList = originalCovidList
    }
    
    /// Funcion para hacer funcinoal el searchbar
    func searchCountry(with searchText: String) {
        if searchText.isEmpty {
            // Restaura la lista completa si el texto de búsqueda está vacío.
            covidList = originalCovidList
        } else {
            // Filtra la lista original de los países según el texto de búsqueda.
            covidList = originalCovidList.filter { covidData in
                return covidData.country.lowercased().contains(searchText.lowercased())
            }
        }
    }
}

