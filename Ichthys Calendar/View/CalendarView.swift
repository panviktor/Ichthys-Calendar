//
//  ContentView.swift
//  Ichthys Calendar
//
//  Created by Viktor on 06.11.2020.
//

import SwiftUI

struct CalendarView: View {
    @ObservedObject var dayViewModel: DayViewModel
    
    init(dayViewModel: DayViewModel) {
        self.dayViewModel = dayViewModel
    }
    
    var body: some View {
        TabView {
            NavigationView {
                VStack {
                    if dayViewModel.fasting.fasting {
                        Text("Not Fasting!")
                    } else {
                        Text("Fasting")
                    }
                    List {
                        ForEach(self.dayViewModel.saints) { saint in
                            NavigationLink(
                                destination: DetailSaintView(detailSaintViewModel: DetailSaintViewModel(saintID: saint.unwrappedID)),
                                label: {
                                    Group {
                                        DayIconImages(url: saint.validImgUrl)
                                        Text("\(saint.title!)")
                                    }
                                }
                            )}
                    }
                    //                    List(self.viewModel.holidays) { holiday in
                    //                        HStack {
                    //                            Text("\(holiday.title!)")
                    //                            Text("\(holiday.metaDescription ?? "")").font(.subheadline)
                    //                        }
                    //                    }
                }
                .navigationBarTitle("Ichthys Calendar")
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        VStack {
                            Button("Today") {
                                self.dayViewModel.getTodayData()
                            }
                        }
                    }
                }
                .navigationBarItems(leading: HStack {
                    Button("Previous day") {
                        self.dayViewModel.getPreviousDayData()
                    }
                }, trailing: HStack {
                    Button("Next Day") {
                        self.dayViewModel.getNextDayData()
                    }
                })
            }
            .tabItem {
                Image(systemName: "calendar")
                Text("Today")
            }
        }
        .onAppear {
            self.dayViewModel.getCalandarDayData()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView(dayViewModel: DayViewModel())
    }
}

