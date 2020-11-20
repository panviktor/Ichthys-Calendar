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
    @State private var dragOffset = CGSize.zero
    @State private var dragGestureText = ""
    @State private var gestureDirection = "goforward"
    @State private var showGestureView = false
    
    init(dayViewModel: DayViewModel) {
        self.dayViewModel = dayViewModel 
    }
    
    var body: some View {
        TabView {
            NavigationView {
                GeometryReader { geometry in
                    colorScheme == .dark ?  Color.black : Color.white
                    ZStack {
                        VStack {
                            ZStack {
                                WaveShape()
                                    .fill(Color(#colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)).opacity(0.3))
                            }
                            .frame(width: geometry.size.width, height: 45)
                            .edgesIgnoringSafeArea(.top)
                            
                            DatePicker("Choose a day", selection: $dayViewModel.date, in: dayViewModel.interval, displayedComponents: [.date])
                                .padding(.horizontal)
                            HolidayRow(holidays: dayViewModel.holidays)
                            ScrollView {
                                LazyVStack {
                                    ForEach(self.dayViewModel.saints) { saint in
                                        NavigationLink(
                                            destination: DetailSaintView(detailSaintViewModel: DetailSaintViewModel(saintID: saint.unwrappedID)),
                                            label: {
                                                SaintRow(saintName: saint.unwrappedTitle, saintImageURL: saint.validImgUrl) })
                                            .buttonStyle(PlainButtonStyle())
                                            .padding(.horizontal)
                                    }
                                }
                            }
                        }
                        if showGestureView {
                            blurView
                                .opacity(0 + Double(abs(dragOffset.width / 50)))
                        }
                    }
                    .gesture(DragGesture(minimumDistance: 80, coordinateSpace: .global)
                                .onChanged { gesture in
                                    self.dragOffset.width = gesture.translation.width
                                    showGestureView = true
                                    if self.dragOffset.width > 0 {
                                        self.dragGestureText = "Will be loaded the next day"
                                        self.gestureDirection = "forward"
                                    } else {
                                        self.dragGestureText = "The previous day will be loaded"
                                        self.gestureDirection = "backward"
                                    }
                                }
                                .onEnded { value in
                                    if abs(self.dragOffset.width) > geometry.size.width * 0.35 {
                                        if self.dragOffset.width > 0 {
                                            dayViewModel.getNextDayData()
                                        } else {
                                            dayViewModel.getPreviousDayData()
                                        }
                                    }
                                    self.dragOffset = .zero
                                    showGestureView = false
                                })
                    .navigationBarTitle("Ichthys Calendar", displayMode: .inline)
                }.navigationBarHidden(true)
                WelcomeView()
            }
            .tabItem {
                Image(systemName: "calendar")
                Text("Today")
            }
            SavedSaint()
                .tabItem {
                    Image(systemName: "heart.circle")
                    Text("Saved")
                }
            About()
                .tabItem {
                    Image(systemName: "info.circle")
                    Text("About")
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

//MARK: - SupportingViews
extension CalendarView {
    var blurView: some View {
        ZStack {
            Constant.gradient.opacity(0.5)
                .blur(radius: 5)
            VStack(alignment: .center, spacing: 10) {
                Text(dragGestureText)
                    .font(.headline)
                    .multilineTextAlignment(.center)
                    .padding()
                Image(systemName: gestureDirection)
                    .font(Font.title.weight(.bold))
                    .foregroundColor(.secondary)
            }
        }
        .cornerRadius(25)
        .frame(width: 200, height: 200, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
    }
}
