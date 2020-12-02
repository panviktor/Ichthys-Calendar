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
            DisclosureGroup(
                isExpanded: $expanded,
                content: {
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
                                    Text(viewModel.fastingName).font(.title3).fontWeight(.bold).lineLimit(2)
                                }
                                .cornerRadius(15)
                                .padding(6)
                                .modifier(BasicNeumorphicShadow())
                            }
                            ZStack {
                                Rectangle()
                                    .fill(Constant.gradientBackground)
                                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                                HStack {
                                    Text(viewModel.weekday.localizedCapitalized)
                                    Spacer()
                                    Text(viewModel.voice)
                                }
                                .padding(.horizontal)
                            }
                            .cornerRadius(15)
                            .padding(6)
                            .modifier(BasicNeumorphicShadow())
                            
                            if viewModel.isFasting  {
                                ZStack {
                                    Rectangle()
                                        .fill(Constant.gradientBackground)
                                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                                    Text(NSLocalizedString("Fasting", comment: ""))
                                        .font(.callout).fontWeight(.bold)
                                }
                                .cornerRadius(15)
                                .padding(6)
                                .modifier(BasicNeumorphicShadow())
                            } else {
                                ZStack {
                                    Rectangle()
                                        .fill(Constant.gradientBackground)
                                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                                    Text(NSLocalizedString("Not Fasting", comment: ""))
                                        .font(.callout)
                                }
                                .cornerRadius(15)
                                .padding(6)
                                .modifier(BasicNeumorphicShadow())
                            }
                            
                            ZStack {
                                Rectangle()
                                    .fill(Constant.gradientBackground)
                                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                                Text(viewModel.roundWeek)
                            }
                            .cornerRadius(15)
                            .padding(6)
                            .modifier(BasicNeumorphicShadow())
                        }
                    }
                    .cornerRadius(15)
                    .padding(10)
                    .modifier(BasicNeumorphicShadow())
                },
                label: {
                    Text(NSLocalizedString("Days info", comment: ""))
                        .font(.headline)
                        .padding(.leading, 5)
                        .modifier(BasicNeumorphicShadow())
                }).padding(.horizontal, 5)
    }
}

struct CurrentFastingView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CurrentDayInfoView(viewModel: CurrentDayInfoViewModel(date: Date(), dayInfo: Fasting.init()))
        }
    }
}

