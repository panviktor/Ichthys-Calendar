//
//  HolidayView.swift
//  Ichthys Calendar
//
//  Created by Viktor on 18.11.2020.
//

import SwiftUI

struct HolidayView: View {
    @ObservedObject var viewModel: HolidayViewViewModel
    @State private var expanded: Bool = true
    
    var body: some View {
        if !viewModel.holidays.isEmpty  {
            DisclosureGroup(
                isExpanded: $expanded,
                content: {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 2) {
                            ForEach(viewModel.holidays) { holiday in
                                HolidayItem(holiday: holiday)
                            }
                        }
                    }
                    .cornerRadius(15)
                    .padding(10)
                    .modifier(BasicNeumorphicShadow())
                },
                label: {
                    Text(viewModel.holidays.count > 1 ? (NSLocalizedString("Holidays", comment: "")) : (NSLocalizedString("Holiday", comment: "")))
                        .font(.headline)
                        .modifier(BasicNeumorphicShadow())
                }).padding(.horizontal, 5)
        }
    }
}

struct HolidayView_Previews: PreviewProvider {
    static var previews: some View {
        HolidayView(viewModel: HolidayViewViewModel.init(holidays: Holiday.mocHolidays))
    }
}

