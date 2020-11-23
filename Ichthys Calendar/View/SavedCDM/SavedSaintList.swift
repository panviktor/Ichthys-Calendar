//
//  SavedSaintList.swift
//  Ichthys Calendar
//
//  Created by Viktor on 19.11.2020.
//

import SwiftUI
import CoreData

struct SavedSaintList: View {
    @Environment(\.colorScheme) var colorScheme
    @StateObject var savedSaintViewModelList = SavedSaintViewModelList()
    
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                colorScheme == .dark ?  Color.black : Color.white
                ZStack {
                    VStack {
                        ZStack {
                            WaveShape()
                                .fill(Color(#colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)).opacity(0.3))
                        }
                        .frame(width: geometry.size.width, height: 35 )
                        .edgesIgnoringSafeArea(.top)
                        
                        ScrollView {
                            LazyVStack {
                                ForEach(self.savedSaintViewModelList.saints) { saint in
                                    NavigationLink(
                                        destination:
                                            DetailSavedSaint(detailSavedSaintViewModel: DetailSavedSaintViewModel(saintServerID: Int(saint.serverID))),
                                        label: {
                                            SaintRow(saintName: saint.unwrappedFullName,
                                                     saintSavedImage:  saint.unwrappedToImage.compactMap { $0.image }.compactMap { UIImage(data: $0) }.first )
                                            
                                        })
                                        .buttonStyle(PlainButtonStyle())
                                        .padding(.horizontal)
                                }
                            }
                        }
                        
                    }
                }
            }
        }.onAppear {
            savedSaintViewModelList.updateScreen()
        }
    }
}

