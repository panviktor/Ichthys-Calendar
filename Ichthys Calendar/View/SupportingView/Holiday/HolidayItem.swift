//
//  HolidayItem.swift
//  Ichthys Calendar
//
//  Created by Viktor on 26.11.2020.
//

import SwiftUI
struct HolidayItem: View {
    var holiday: Holiday
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Constant.gradientBackground)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            HStack(alignment: .center) {
                ScrollView(.vertical, showsIndicators: false) {
                    Text(holiday.unwrappedTitle)
                        .padding(.vertical)
                        .multilineTextAlignment(.center)
                        .lineLimit(3)
                    Text(holiday.unwrappedMetaDescription)
                        .multilineTextAlignment(.center)
                }
                .font(.footnote)
                .foregroundColor(.primary)
                .padding()
                if let url = holiday.firstPreviewValidUrl {
                    HolidayIcon(url: url)
                        .padding()
                }
            }
        }
        .cornerRadius(15)
        .frame(width: 300)
        .padding()
        .modifier(BasicNeumorphicShadow())
    }
}
