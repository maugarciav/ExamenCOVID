//
//  ContentView.swift
//  ExamenCOVID
//
//  Created by Mauricio Garcia Villanueva on 23/11/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var contentViewModel = ContentViewModel()
    @State private var searchText: String = ""

    var body: some View {
        VStack(spacing: 0) {
            Text("Casos de COVID por país desde 2022")
                .font(.headline)
                .padding()

            NavigationView {
                List(contentViewModel.covidList, id: \.country) { res in
                    VStack(alignment: .leading) {
                        Text(res.country)
                            .font(.headline)
                        HStack {
                            if !res.region.isEmpty {
                                Text("Región: \(res.region)")
                                    .foregroundColor(.secondary)
                            }
                            Spacer()
                            Text("Total: \(res.cases.total)")
                        }
                        .font(.subheadline)
                    }
                    .padding(.vertical, 8)
                }
            }.searchable(
                text: $searchText,
                placement: .navigationBarDrawer(displayMode: .always),
                prompt: "Buscar país")

            .navigationTitle("COVID")

            .onChange(of: searchText) { newValue in
                // Cuando el texto de búsqueda cambia, llama a la función de búsqueda en el ViewModel
                contentViewModel.searchCountry(with: newValue)
            }.onAppear {
                Task {
                    await contentViewModel.getCovidData()
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
