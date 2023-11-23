//
//  ContentViewModel.swift
//  ExamenCOVID
//
//  Created by Mauricio Garcia Villanueva on 23/11/23.
//

import Foundation

// ContentViewModel.swift
import Foundation

/// ViewModel se encarga de la  lógica de la vista
class ContentViewModel: ObservableObject {
    @Published var covidList = [CovidData]()
    private var originalCovidList = [CovidData]()
    @Published var sortOrder: SortOrder = .descending

    enum SortOrder {
        case ascending
        case descending
    }

    var covidListRequirement: CovidListRequirement

    init(covidListRequirement: CovidListRequirement = CovidListRequirement()) {
        self.covidListRequirement = covidListRequirement
    }

    @MainActor
    func getCovidData() async {
        originalCovidList = await covidListRequirement.getCovidList() ?? []
        covidList = originalCovidList
    }

    func searchCountry(with searchText: String) {
        if searchText.isEmpty {
            covidList = originalCovidList
        } else {
            covidList = originalCovidList.filter { covidData in
                return covidData.country.lowercased().contains(searchText.lowercased())
            }
        }
    }

    func toggleSortOrder() {
        sortOrder = sortOrder == .ascending ? .descending : .ascending
        updateSortedCovidList()
    }

    private func updateSortedCovidList() {
        covidList = originalCovidList.sorted(by: { sortOrder == .ascending ? $0.cases.total < $1.cases.total : $0.cases.total > $1.cases.total })
    }
}

