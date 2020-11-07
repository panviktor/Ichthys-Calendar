//
//  ContentView.swift
//  Ichthys Calendar
//
//  Created by Viktor on 06.11.2020.
//

import SwiftUI

struct CalendarView: View {
    @ObservedObject var viewModel = CalendarViewModel()
    
    var body: some View {
        TabView {
            NavigationView {
                List(self.viewModel.saints) { saint in
                    HStack {
                        DayIconImages()
                        Text("\(saint.title!)")
                        Text("\(saint.name!)")
                            .onAppear {
                                print(saint.imgs!)
                            }
                    }
                }
                .navigationBarTitle("Ichthys Calendar")
            }
            .tabItem {
                Image(systemName: "calendar")
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
        CalendarView()
    }
}

