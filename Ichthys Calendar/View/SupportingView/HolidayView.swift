//
//  HolidayView.swift
//  Ichthys Calendar
//
//  Created by Viktor on 18.11.2020.
//

import SwiftUI

struct HolidayView: View {
    var holidays: [Holiday]
    @State private var expanded: Bool = true
    
    var body: some View {
        if !holidays.isEmpty {
            DisclosureGroup(
                isExpanded: $expanded,
                content: {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 2) {
                            ForEach(holidays) { holiday in
                                HolidayItem(holiday: holiday)
                            }
                        }
                    }
                },
                label: {
                    Text(holidays.count > 1 ? "Holidays" : "Holiday")
                        .font(.headline)
                }).padding(.horizontal)
        }
    }
}

struct HolidayItem: View {
    var holiday: Holiday
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 15)
                .stroke(Color.red, lineWidth: 3)
                .foregroundColor(.gray)
                .opacity(0.75)
                .shadow(radius: 5)
            VStack {
                Text(holiday.unwrappedTitle)
                    .font(.footnote)
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
                    .lineLimit(3)
            }
        }
        .frame(width: 270, height: 75)
        .padding(5)
    }
}

struct HolidayView_Previews: PreviewProvider {
    static var previews: some View {
        HolidayView(holidays: Holiday.mocHolidays)
    }
}
