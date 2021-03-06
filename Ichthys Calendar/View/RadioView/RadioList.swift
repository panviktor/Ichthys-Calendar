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
    @State private var selectedStation: RadioStation? = nil
    
    let portraitLayout = [GridItem(.flexible()), GridItem(.flexible())]
    let landscapeLayout = [GridItem(.flexible())]
    
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
                        ScrollView {
                            LazyVGrid(columns: portraitLayout, alignment: .center, spacing: 5) {
                                ForEach(viewModel.stations) { station in
                                    RadioRow(station: station)
                                        .onTapGesture {
                                            viewModel.playRadioStation(station)
                                        }
                                        .onLongPressGesture(minimumDuration: 1.5) {
                                            selectedStation = station
                                        }
                                }
                            }
                        }
                        .padding(.horizontal, 2.5)
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
                                        Text(viewModel.currentStation?.name ?? NSLocalizedString("Choose radio station", comment: ""))
                                            .font(.callout)
                                            .bold()
                                            .padding()
                                        VStack(alignment: .leading) {
                                            Text(viewModel.trackName)
                                                .font(.caption2)
                                                .padding(.bottom, 5)
                                        }
                                        
                                        HStack(alignment: .center, spacing: 10) {
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
                                    .compositingGroup()
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
                                .compositingGroup()
                            }
                            .frame(width: geometry.size.width / 1.8)
                            .cornerRadius(15)
                            .padding(5)
                            
                            Spacer()
                            VStack {
                                Spacer()
                                ScrollView(.horizontal, showsIndicators: false) {
                                    LazyHGrid(rows: landscapeLayout, alignment: .center, spacing: 10) {
                                        ForEach(viewModel.stations) { station in
                                            RadioRow(station: station)
                                                .onTapGesture {
                                                    viewModel.playRadioStation(station)
                                                }
                                                .onLongPressGesture(minimumDuration: 2) {
                                                    selectedStation = station
                                                }
                                        }
                                    }
                                }
                                .padding(5)
                                Spacer()
                            }
                            Spacer()
                        }
                    }
                }
            }
            .sheet(item: $selectedStation) { station in
                DetailRadioView(station: station)
            }
        }
        
    }
}

struct RadioView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            RadioList(viewModel: RadioViewViewModel())
                .environmentObject(OrientationInfo())
            RadioList(viewModel: RadioViewViewModel())
                .environmentObject(OrientationInfo())
                .preferredColorScheme(.dark)
                .previewDevice("iPod touch (7th generation)")
        }
    }
}
