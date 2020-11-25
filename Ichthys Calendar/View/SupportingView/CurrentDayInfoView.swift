//
//  CurrentDayInfoView.swift
//  Ichthys Calendar
//
//  Created by Viktor on 24.11.2020.
//

import SwiftUI

struct CurrentDayInfoView: View {
    @State var fastingName: String
    @State var isFasting: FastingEnum
    @State var roundWeek: String
    @State var voice: String
    @State var weekday: String
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Constant.gradientBackground)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .edgesIgnoringSafeArea(.all)
            VStack {
                if !fastingName.isEmpty {
                    ZStack {
                        Rectangle()
                            .fill(Constant.gradientBackground)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                        Text(fastingName).font(.title2).fontWeight(.bold).lineLimit(2)
                    }
                    .cornerRadius(15)
                    .padding(10)
                    .modifier(BasicNeumorphicShadow())
                }
                
                ZStack {
                    Rectangle()
                        .fill(Constant.gradientBackground)
                    HStack {
                        Text(weekday)
                        Spacer()
                        Text(voice)
                    }
                    .padding(.horizontal)
                }
                .cornerRadius(15)
                .padding(.horizontal)
                .modifier(BasicNeumorphicShadow())
                
                if isFasting == .fasting {
                    ZStack {
                        Rectangle()
                            .fill(Constant.gradientBackground)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                        Text(isFasting.rawValue)
                            .font(.callout).fontWeight(.bold)
                    }
                    .cornerRadius(15)
                    .padding(10)
                    .modifier(BasicNeumorphicShadow())
                } else {
                    ZStack {
                        Rectangle()
                            .fill(Constant.gradientBackground)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                        Text(isFasting.rawValue)
                            .font(.callout)
                    }
                    .cornerRadius(15)
                    .padding(10)
                    .modifier(BasicNeumorphicShadow())
                }
                
                ZStack {
                    Rectangle()
                        .fill(Constant.gradientBackground)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    Text(roundWeek)
                }
                .cornerRadius(15)
                .padding(10)
                .modifier(BasicNeumorphicShadow())
            }
        }
        .cornerRadius(15)
        .padding(.horizontal)
        .modifier(BasicNeumorphicShadow())
        .frame(height: 70, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
    }
}

struct CurrentFastingView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CurrentDayInfoView(fastingName: "Рождественский пост", isFasting: .fasting, roundWeek: "25 неделя", voice: "Глас 4", weekday: "Суббота")
            CurrentDayInfoView(fastingName: "Рождественский пост", isFasting: .fasting, roundWeek: "25 неделя", voice: "Глас 4", weekday: "Суббота")
                .preferredColorScheme(.dark)
        }
    }
}

