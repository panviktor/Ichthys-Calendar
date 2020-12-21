//
//  Ichthys_CalendarApp.swift
//  Ichthys Calendar
//
//  Created by Viktor on 06.11.2020.
//

import SwiftUI

@main
struct Ichthys_CalendarApp: App {
    @Environment(\.scenePhase) private var scenePhase
    
    let calendarCoreDataManager = PersistenceManager.shared
    let storeReviewHelper = StoreReviewHelper.shared
   
    init() {
        UIApplication.shared.beginReceivingRemoteControlEvents()
    }
    
    var body: some Scene {
        WindowGroup {
            CalendarView(dayViewModel: DayViewModel())
                .environment(\.managedObjectContext, calendarCoreDataManager.persistentContainer.viewContext)
        }
        .onChange(of: scenePhase) { phase in
            switch phase {
            case .active:
                storeReviewHelper.incrementAppOpenedCount()
                storeReviewHelper.checkAndAskForReview()
                print("active")
            case .inactive:
                print("inactive")
            case .background:
                print("background")
                calendarCoreDataManager.saveContext()
            @unknown default:
                print("unknown")
            }
        }
    }
}
