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
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            CalendarView(dayViewModel: DayViewModel())
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
        .onChange(of: scenePhase) { phase in
            switch phase {
            case .active:
                print("active")
            case .inactive:
                print("inactive")
            case .background:
                print("background")
                if persistenceController.container.viewContext.hasChanges {
                   try? persistenceController.container.viewContext.save()
                }
            @unknown default:
                print("unknown")
            }
        }
    }
}
