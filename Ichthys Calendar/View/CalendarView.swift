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
                VStack{
                    Group {
                        DatePicker("date", selection: $dayViewModel.date, in: dayViewModel.interval, displayedComponents: [.date])
                    }
                    
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
                                    HStack {
                                        Group {
                                            if let url = saint.validImgUrl {
                                                DayIconImages(url: url)
                                            } else {
                                                MainImagePlaceholder()
                                            }
                                        }
                                        .frame(width: 100, height: 100)
                                        Text("\(saint.title!)")
                                    }
                                }
                            )}
                    }
//                    ScrollView(.horizontal) {
//                        ForEach(self.dayViewModel.holidays) { holiday in
//                            HStack {
//                                Text("\(holiday.title!)")
//                                Text("\(holiday.metaDescription ?? "")").font(.subheadline)
//                            }
//                        }
//                    }
                }
                .navigationBarTitle("Ichthys Calendar", displayMode: .inline)
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        VStack {
                            todayButton
                        }
                    }
                }
                .navigationBarItems(leading: HStack {
                    previousDayButton
                }, trailing: HStack {
                    nextDayButton
                })
                WelcomeView()
            }
            .tabItem {
                Image(systemName: "calendar")
                Text("Today")
            }
        }
        .onAppear {
            self.dayViewModel.getTodayData()
        }
    }
}

struct ContentView_PreviewsCalendarViewNew: PreviewProvider {
    static var previews: some View {
        CalendarView(dayViewModel: DayViewModel())
    }
}

//MARK: - Buttons
extension CalendarView {
    var previousDayButton : some View { Button(action: {
        self.dayViewModel.getPreviousDayData()
    }) {
        HStack {
            Image(systemName: "chevron.backward.2")
                .animation(.easeInOut(duration: 0.5))
        }}
    .animation(.spring())
    }
    
    var nextDayButton : some View { Button(action: {
        self.dayViewModel.getNextDayData()
    }) {
        HStack {
            Image(systemName: "chevron.forward.2")
                .animation(.easeInOut(duration: 0.5))
        }}
    .animation(.spring())
    }
    
    var todayButton : some View { Button(action: {
        self.dayViewModel.getTodayData()
    }) {
        HStack {
            Image(systemName: "calendar")
        }}
    }
}
