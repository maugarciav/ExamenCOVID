//
//  ContentView.swift
//  ExamenCOVID
//
//  Created by Mauricio Garcia Villanueva on 23/11/23.
//


import SwiftUI

struct ContentView: View {
    @StateObject var contentViewModel = ContentViewModel()
    
    var body: some View {
        List(contentViewModel.covidList, id: \.country) { res in
            HStack {
                Text(res.country)
            }
            
            
        }.onAppear {
            Task {
                await contentViewModel.getCovidData()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


/*
 Info que regresa:
 "country": "Afghanistan",
  "region": "",
  "cases": {
      "total": 158107,
      "new": 23
  }
},
 
 */
