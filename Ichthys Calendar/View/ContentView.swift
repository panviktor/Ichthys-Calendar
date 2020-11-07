//
//  ContentView.swift
//  Ichthys Calendar
//
//  Created by Viktor on 06.11.2020.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel = CalendarViewModel()
    
    var body: some View {
        TabView {
            NavigationView {
                List(self.viewModel.saints) { saint in
                    HStack {
                        Text("\(saint.title!)")
                        Text("\(saint.name!)")
                    }
                }
                .navigationBarTitle("Ichthys Calendar")
            }
            .tabItem {
                Image(systemName: "person.3")
                Text("Today")
            }
        }
        .onAppear {
            self.viewModel.getCalandarDayData()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
