//
//  DayInfoEntry.swift
//  Ichthys Calendar WidgetExtension
//
//  Created by Viktor on 29.11.2020.
//

import WidgetKit
import SwiftUI

struct DayInfoEntry: TimelineEntry {
    let date: Date
    let dayInfo: DayInfo
    var relevance: TimelineEntryRelevance? {
        return TimelineEntryRelevance(score: 10)
    }
}

