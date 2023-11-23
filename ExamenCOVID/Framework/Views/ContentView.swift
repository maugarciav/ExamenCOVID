//
//  ContentView.swift
//  ExamenCOVID
//
//  Created by Mauricio Garcia Villanueva on 23/11/23.
//

// ContentView.swift
import SwiftUI

// Vista principal
struct ContentView: View {
    @StateObject var contentViewModel = ContentViewModel()
    @State private var searchText: String = ""

    var body: some View {
        VStack(spacing: 0) {
            HStack {
                // Título
                Text("Casos de COVID actuales")
                    .font(.headline)
                    .padding()
                
                Spacer()
                
                // Botón para cambiar el orden de la lista.
                Button(action: {
                    contentViewModel.toggleSortOrder()
                }) {
                    Text("Ordenar")
                    Image(systemName: contentViewModel.sortOrder == .ascending ? "arrow.up" : "arrow.down")
                        .imageScale(.medium)
                }
                .padding()
            }

            // Lista de casos de COVID con búsqueda y ordenación.
            NavigationView {
                List(contentViewModel.covidList.sorted(by: { contentViewModel.sortOrder == .ascending ? $0.cases.total < $1.cases.total : $0.cases.total > $1.cases.total }), id: \.country) { res in
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

            .onChange(of: searchText) { newValue in
                contentViewModel.searchCountry(with: newValue)
            }
            
            // Carga inicial de datos al aparecer la vista.
            .onAppear {
                Task {
                    await contentViewModel.getCovidData()
                }
            }
        }
    }
}

// ContentView_Previews y otros códigos relacionados...



// Vista previa para el desarrollo.
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

