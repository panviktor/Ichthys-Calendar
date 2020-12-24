//
//  RadioList.swift
//  Ichthys Calendar
//
//  Created by Viktor on 19.12.2020.
//

import SwiftUI

struct RadioList: View {
    @StateObject var viewModel: RadioViewViewModel
    @EnvironmentObject var orientationInfo: OrientationInfo
    @Environment(\.colorScheme) var colorScheme
    @State var isPlaying = true
    
    var body: some View {
        GeometryReader { geometry in
            colorScheme == .dark ? Color.black : Color.white
            ZStack {
                VStack {
                    ZStack {
                        WaveShape()
                            .fill(Color(#colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)).opacity(0.3))
                    }
                    .frame(width: geometry.size.width, height: 15)
                    .edgesIgnoringSafeArea(.top)
                    
                    if orientationInfo.orientation == .portrait {
                        Spacer()
                        Text("Grid 2")
                        Spacer()
                        
                        //MARK: - Portrait Player GUI
                        ZStack {
                            Rectangle()
                                .fill(Constant.gradientBackground)
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                .edgesIgnoringSafeArea(.all)
                            VStack {
                                ZStack {
                                    Rectangle()
                                        .fill(Constant.gradientBackground)
                                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                                    VStack {
                                        Text(viewModel.currentStation?.name ?? "Choose radio station")
                                            .font(.callout)
                                            .padding()
                                        HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 10) {
                                            Button(action: {
                                                viewModel.previousStation()
                                            }) {
                                                Image(systemName: "backward.fill")
                                                    .foregroundColor(.red)
                                                    .font(.title)
                                            }
                                            .buttonStyle((RadioButtonStyle()))
                                            
                                            Button(action: {
                                                isPlaying.toggle()
                                                viewModel.togglePlaying()
                                            }) {
                                                Image(systemName: isPlaying ? "play.circle.fill" : "pause.circle.fill")
                                                    .foregroundColor(.red)
                                                    .font(.title)
                                            }
                                            .buttonStyle((RadioButtonStyle()))
                                            
                                            Button(action: {
                                                viewModel.stop()
                                            }) {
                                                Image(systemName: "stop.fill")
                                                    .foregroundColor(.red)
                                                    .font(.title)
                                            }
                                            .buttonStyle((RadioButtonStyle()))
                                            
                                            Button(action: {
                                                viewModel.nextStation()
                                            }) {
                                                Image(systemName: "forward.fill")
                                                    .foregroundColor(.red)
                                                    .font(.title)
                                            }
                                            .buttonStyle((RadioButtonStyle()))
                                        }
                                        .padding(.bottom )
                                    }
                                }
                                .cornerRadius(15)
                                .padding(6)
                                .modifier(BasicNeumorphicShadow())
                            }
                        }
                        .frame(height: geometry.size.width / 2)
                        .cornerRadius(15)
                        .padding(5)
                    } else {
                        //MARK: - Landscape Player GUI
                        HStack {
                            ZStack {
                                Rectangle()
                                    .fill(Constant.gradientBackground)
                                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                                    .edgesIgnoringSafeArea(.all)
                                VStack {
                                    ZStack {
                                        Rectangle()
                                            .fill(Constant.gradientBackground)
                                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                                        VStack {
                                            Spacer()
                                            if let image = viewModel.currentStation?.stationImage, let uiImage = UIImage(named: image) {
                                                Image(uiImage: uiImage)
                                                    .resizable()
                                                    .aspectRatio(contentMode: .fit)
                                                    .padding(1)
                                                    .frame(minWidth: geometry.size.width * 0.15,
                                                           maxWidth: geometry.size.width * 0.35,
                                                           minHeight: geometry.size.width * 0.15,
                                                           maxHeight: geometry.size.width * 0.35)
                                            } else {
                                                Image(uiImage: Constant.radioImage)
                                                    .resizable()
                                                    .aspectRatio(contentMode: .fit)
                                                    .padding(1)
                                                    .frame(minWidth: geometry.size.width * 0.15,
                                                           maxWidth: geometry.size.width * 0.35,
                                                           minHeight: geometry.size.width * 0.15,
                                                           maxHeight: geometry.size.width * 0.35)
                                            }
                                            
                                            Text(viewModel.currentStation?.name ?? "Choose radio station")
                                                .font(.callout)
                                                .padding(.vertical)
                                            HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 10) {
                                                Button(action: {
                                                    viewModel.previousStation()
                                                }) {
                                                    Image(systemName: "backward.fill")
                                                        .foregroundColor(.red)
                                                        .font(.title)
                                                }
                                                .buttonStyle((RadioButtonStyle()))
                                                
                                                Button(action: {
                                                    isPlaying.toggle()
                                                    viewModel.togglePlaying()
                                                }) {
                                                    Image(systemName: isPlaying ? "play.circle.fill" : "pause.circle.fill")
                                                        .foregroundColor(.red)
                                                        .font(.title)
                                                }
                                                .buttonStyle((RadioButtonStyle()))
                                                
                                                Button(action: {
                                                    viewModel.stop()
                                                }) {
                                                    Image(systemName: "stop.fill")
                                                        .foregroundColor(.red)
                                                        .font(.title)
                                                }
                                                .buttonStyle((RadioButtonStyle()))
                                                
                                                Button(action: {
                                                    viewModel.nextStation()
                                                }) {
                                                    Image(systemName: "forward.fill")
                                                        .foregroundColor(.red)
                                                        .font(.title)
                                                }
                                                .buttonStyle((RadioButtonStyle()))
                                            }
                                            .padding(.bottom, 5)
                                        }
                                    }
                                    .cornerRadius(15)
                                    .padding(6)
                                    .modifier(BasicNeumorphicShadow())
                                }
                            }
                            .frame(width: geometry.size.width / 1.8)
                            .cornerRadius(15)
                            .padding(5)
                            
                            Spacer()
                        }
                    }
                }
            }
        }
    }
}

struct RadioView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            RadioList(viewModel: RadioViewViewModel())
            RadioList(viewModel: RadioViewViewModel())
                .preferredColorScheme(.dark)
                .previewDevice("iPod touch (7th generation)")
        }
    }
}
