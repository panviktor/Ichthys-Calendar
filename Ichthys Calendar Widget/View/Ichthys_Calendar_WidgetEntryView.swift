//
//  Ichthys_Calendar_WidgetEntryView.swift
//  Ichthys Calendar WidgetExtension
//
//  Created by Viktor on 29.11.2020.
//

import WidgetKit
import SwiftUI

struct Ichthys_Calendar_WidgetEntryView: View {
    @Environment(\.widgetFamily) private var widgetFamily
    var entry: DayInfoEntry
    
    var body: some View {
        if widgetFamily == .systemSmall {
            smallWidget
        } else {
            mediumWidget
        }
    }
    
    var smallWidget: some View {
        ZStack(alignment: .topLeading) {
            Constant.gradientBackground
            ContainerRelativeShape()
                .inset(by: 8)
                .fill(Constant.gradientBackground)
                .modifier(BasicNeumorphicShadow())
            VStack(alignment: .leading) {
                HStack {
                    Text(entry.dayInfo.weekday)
                        .font(.headline)
                    Spacer()
                    Text(entry.dayInfo.dayNumber)
                        .bold()
                }.padding(.bottom, 0.5)
                
                if entry.dayInfo.isFasting {
                    Text("Fasting")
                        .font(.headline).fontWeight(.bold).foregroundColor(.red)
                        .padding(.top, 0.5)
                } else {
                    Text("No fasting")
                        .font(.subheadline).fontWeight(.bold)
                        .padding(.top, 0.5)
                }
                
                VStack(alignment: .center) {
                    Text(entry.dayInfo.fastingName)
                        .font(.footnote)
                        .multilineTextAlignment(.center)
                        .padding(.top, 0.5)
                        .layoutPriority(10)
                    Divider()
                    Text(entry.dayInfo.holiday)
                        .font(.footnote)
                        .multilineTextAlignment(.center)
                }
            }
            .padding()
        }
        .cornerRadius(15)
        .padding(.vertical, 1)
        .modifier(BasicNeumorphicShadow())
    }
    
    var mediumWidget: some View {
        ZStack(alignment: .topLeading) {
            Constant.gradientBackground
            ContainerRelativeShape()
                .inset(by: 8)
                .fill(Constant.gradientBackground)
                .modifier(BasicNeumorphicShadow())
            VStack(alignment: .leading) {
                HStack {
                    Text(entry.dayInfo.weekday)
                        .fontWeight(.heavy)
                        .font(.headline)
                    Spacer()
                    Text(entry.dayInfo.dayNumber)
                        .fontWeight(.heavy)
                        .bold()
                }.padding(.bottom, 0.5)
                
                if entry.dayInfo.isFasting {
                    Text("Fasting")
                        .font(.headline).fontWeight(.heavy).foregroundColor(.red)
                        .padding(.top, 0.5)
                } else {
                    Text("No fasting")
                        .font(.subheadline).fontWeight(.bold)
                        .padding(.top, 0.5)
                }
                
                VStack(alignment: .center) {
                    Divider()
                    Text(entry.dayInfo.fastingName)
                        .font(.body)
                        .multilineTextAlignment(.center)
                        .padding(.top, 0.5)
                        .layoutPriority(10)
                    Divider()
                    Text(entry.dayInfo.holiday)
                        .font(.footnote)
                        .multilineTextAlignment(.center)
                }
            }
            .padding()
        }
        .cornerRadius(15)
        .padding(.vertical, 1)
        .modifier(BasicNeumorphicShadow())
    }
}

struct Ichthys_Calendar_Widget_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            Ichthys_Calendar_WidgetEntryView(entry: DayInfoEntry(date: Date(), dayInfo: DayInfo.mocDayInfo))
                .previewContext(WidgetPreviewContext(family: .systemSmall))
            
            Ichthys_Calendar_WidgetEntryView(entry: DayInfoEntry(date: Date(), dayInfo: DayInfo.mocDayInfo))
                .previewContext(WidgetPreviewContext(family: .systemMedium))
            
            Ichthys_Calendar_WidgetEntryView(entry: DayInfoEntry(date: Date(), dayInfo: DayInfo.mocDayInfo))
                .previewContext(WidgetPreviewContext(family: .systemSmall))
                .environment(\.colorScheme, .dark)
            
            Ichthys_Calendar_WidgetEntryView(entry: DayInfoEntry(date: Date(), dayInfo: DayInfo.mocDayInfo))
                .previewContext(WidgetPreviewContext(family: .systemMedium))
                .environment(\.colorScheme, .dark)
        }
    }
}
