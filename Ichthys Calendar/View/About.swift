//
//  About.swift
//  Ichthys Calendar
//
//  Created by Viktor on 19.11.2020.
//

import SwiftUI
import StoreKit
import MessageUI

struct About: View {
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.openURL) var openURL
    @State var result: Result<MFMailComposeResult, Error>? = nil
    @State var isShowingMailView = false
    
    var body: some View {
        GeometryReader { geometry in
            colorScheme == .dark ? Color.black : Color.white
            ZStack {
                VStack {
                    ZStack {
                        WaveShape()
                            .fill(Color(#colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)).opacity(0.3))
                    }
                    .frame(width: geometry.size.width, height: 20)
                    .edgesIgnoringSafeArea(.top)
                    
                    ZStack {
                        Rectangle()
                            .fill(Constant.gradientBackground)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .edgesIgnoringSafeArea(.all)
                        VStack {
                            Spacer()
                            Text("Ichthys Calendar")
                                .font(.title)
                                .padding()
                            Text("Thank you for the data provided by the site azbyka.ru")
                                .font(.subheadline)
                                .multilineTextAlignment(.center)
                                .padding()
                            Button("Visit azbyka.ru") {
                                openURL(URL(string: "https://azbyka.ru")!)
                            }
                            Spacer()
                            Button("You will greatly help the project if you leave a review.") {
                                StoreReviewHelper.shared.requestFullReview()
                            }
                            Spacer()
                            Button(action: {
                                self.isShowingMailView.toggle()
                            }) {
                                Text("Tap Me")
                            }
                            .disabled(!MFMailComposeViewController.canSendMail())
                            .sheet(isPresented: $isShowingMailView) {
                                MailView(result: self.$result)
                            }
                        }
                    }
                    .cornerRadius(15)
                    .padding(15)
                    .modifier(BasicNeumorphicShadow())
                }
            }
        }
    }
}

struct About_Previews: PreviewProvider {
    static var previews: some View {
        About()
    }
}
