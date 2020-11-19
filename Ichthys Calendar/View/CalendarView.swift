//
//  ContentView.swift
//  Ichthys Calendar
//
//  Created by Viktor on 06.11.2020.
//

import SwiftUI

struct CalendarView: View {
    @Environment(\.colorScheme) var colorScheme
    @ObservedObject var dayViewModel: DayViewModel

    init(dayViewModel: DayViewModel) {
        self.dayViewModel = dayViewModel 
    }
    
    var body: some View {
        TabView {
            NavigationView {
                GeometryReader { geometry in
                    colorScheme == .dark ?  Color.black : Color.white
                    VStack {
                        ZStack {
                            WaveShape()
                                .fill(Color(#colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)).opacity(0.3))
                        }
                        .frame(width: geometry.size.width, height: 45)
                        .edgesIgnoringSafeArea(.top)
                        Spacer()
                        
                        VStack{
                            DatePicker("Choose a day", selection: $dayViewModel.date, in: dayViewModel.interval, displayedComponents: [.date])
                                .padding(.horizontal)
                            Divider()
                            HolidayView(holidays: dayViewModel.holidays)
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
                                                Text("\(saint.unwrappedTitle)")
                                            }
                                            
                                            
                                        }
                                    )}
                            }
                        }
                        Spacer()
                    }
                    
                    .navigationBarTitle("Ichthys Calendar", displayMode: .inline)
                }.navigationBarHidden(true)
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
