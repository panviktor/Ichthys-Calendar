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
                
                VStack {
                    List(self.viewModel.saints) { saint in
                        HStack {
                            //FIXME: Fix model!
                            DayIconImages(url: saint.validImgUrl)
                            Text("\(saint.title!)")
                        }
                    }
                    List(self.viewModel.holidays) { holiday in
                        HStack {
                            Text("\(holiday.title!)")
                            Text("\(holiday.metaDescription ?? "")").font(.subheadline)
                        }
                    }
                }
                
                .navigationBarTitle("Ichthys Calendar")
                //  .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        VStack {
                            Button("Today") {
                                self.viewModel.getTodayData()
                            }
                        }
                    }
                }
                .navigationBarItems(leading: HStack {
                    Button("Previous day") {
                        self.viewModel.getPreviousDayData()
                    }
                }, trailing: HStack {
                    Button("Next Day") {
                        self.viewModel.getNextDayData()
                    }
                })
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

