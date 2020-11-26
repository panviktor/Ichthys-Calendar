//
//  CurrentDayInfoView.swift
//  Ichthys Calendar
//
//  Created by Viktor on 24.11.2020.
//

import SwiftUI

struct CurrentDayInfoView: View {
    @ObservedObject var viewModel: CurrentDayInfoViewModel
    @State private var expanded: Bool = true
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Constant.gradientBackground)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .edgesIgnoringSafeArea(.all)
            VStack {
                if !viewModel.fastingName.isEmpty {
                    ZStack {
                        Rectangle()
                            .fill(Constant.gradientBackground)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                        Text(viewModel.fastingName).font(.title2).fontWeight(.bold).lineLimit(2)
                    }
                    .cornerRadius(15)
                    .padding(10)
                    .modifier(BasicNeumorphicShadow())
                }
                
                ZStack {
                    Rectangle()
                        .fill(Constant.gradientBackground)
                    HStack {
                        Text(viewModel.weekday)
                        Spacer()
                        Text(viewModel.voice)
                    }
                    .padding(.horizontal)
                }
                .cornerRadius(15)
                .padding(.horizontal)
                .modifier(BasicNeumorphicShadow())
                
                if viewModel.isFasting  {
                    ZStack {
                        Rectangle()
                            .fill(Constant.gradientBackground)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                        Text("Fasting")
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
                        Text("Not Fasting")
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
                    Text(viewModel.roundWeek)
                }
                .cornerRadius(15)
                .padding(10)
                .modifier(BasicNeumorphicShadow())
            }
        }
        .cornerRadius(15)
        .padding()
        .modifier(BasicNeumorphicShadow())
    }
}

struct CurrentFastingView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CurrentDayInfoView(viewModel: CurrentDayInfoViewModel(date: Date(), dayInfo: Fasting.init()))
        }
    }
}

