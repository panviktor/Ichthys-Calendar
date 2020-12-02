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
                        ScrollView(/*@START_MENU_TOKEN@*/.vertical/*@END_MENU_TOKEN@*/, showsIndicators: false) {
                        VStack(alignment: .center) {
                            Spacer()
                            Text("Ichthys Calendar")
                                .font(.title).fontWeight(.heavy)
                                .padding()
                            Text("Many thanks to the site azbuka.ru for the data provided.")
                                .font(.subheadline)
                                .multilineTextAlignment(.center)
                                .padding()
                            Button("Visit azbyka.ru") {
                                openURL(URL(string: "https://azbyka.ru")!)
                            }
                            Spacer()
                            
                          
                            VStack(alignment: .trailing) {
                                HStack(alignment: .center) {
                                    Text("You will greatly help the project if you leave a review.")
                                        .padding()
                                    Button(action: {
                                        StoreReviewHelper.shared.requestFullReview()
                                    }) {
                                        Image(systemName: "pencil.and.outline")
                                            .foregroundColor(.red)
                                            .font(.title)
                                    }
                                    .buttonStyle(SimpleButtonStyle())
                                }.padding()
                                
                                HStack(alignment: .center) {
                                    Text("Mail for communication and suggestions.")
                                        .padding()
                                    Button(action: {
                                        self.isShowingMailView.toggle()
                                    }) {
                                        Image(systemName: "envelope")
                                            .foregroundColor(.black)
                                            .font(.title)
                                    }
                                    .disabled(!MFMailComposeViewController.canSendMail())
                                    .sheet(isPresented: $isShowingMailView) {
                                        MailView(result: self.$result)
                                    }
                                    .buttonStyle(SimpleButtonStyle())
                                }.padding()
                                
                                HStack(alignment: .center) {
                                    Text("You can share the link to the app with your friends.")
                                        .padding()
                                    
                                    Button(action: {
                                        shareApp()
                                    }) {
                                        Image(systemName: "square.and.arrow.up")
                                            .foregroundColor(.black)
                                            .font(.title)
                                    }
                                    .buttonStyle(SimpleButtonStyle())
                                }.padding()
                                Spacer()
                            }
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
    
    private func shareApp() {
        guard let appURL = URL(string: Constant.appURL) else { return }
        let av = UIActivityViewController(activityItems: [appURL], applicationActivities: nil)
        UIApplication.shared.windows.first?.rootViewController?.present(av, animated: true, completion: nil)
    }
}

struct About_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            About()
            About()
                .environment(\.colorScheme, .dark)
        }
    }
}
