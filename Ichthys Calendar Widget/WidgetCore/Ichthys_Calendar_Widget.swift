//
//  Ichthys_Calendar_Widget.swift
//  Ichthys Calendar Widget
//
//  Created by Viktor on 28.11.2020.
//

import WidgetKit
import SwiftUI

@main
struct Ichthys_Calendar_Widget: Widget {
    let kind: String = "Ichthys_Calendar_Widget"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: DayInfoProvider()) { entry in
            Ichthys_Calendar_WidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Ichthys Calendar Widget")
        .description("Shows the fast day and holiday.")
        .supportedFamilies([.systemSmall, .systemMedium])
    }
}


