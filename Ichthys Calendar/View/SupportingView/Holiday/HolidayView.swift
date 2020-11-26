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
                    }.padding(.horizontal)
                },
                label: {
                    Text(viewModel.holidays.count > 1 ? "Holidays" : "Holiday")
                        .font(.headline)
                }).padding(.horizontal)
        }
    }
}

struct HolidayView_Previews: PreviewProvider {
    static var previews: some View {
        HolidayView(viewModel: HolidayViewViewModel.init(holidays: Holiday.mocHolidays))
    }
}

