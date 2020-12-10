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
                        
                        HStack(spacing: 8) {
                            TextField(NSLocalizedString("Search...", comment: ""), text: $savedSaintViewModelList.searchText)
                            Image(systemName: "magnifyingglass")
                                .imageScale(.medium)
                        }
                        .padding(.top, 5)
                        .padding(.leading, 20)
                        .padding(.trailing, 20)
                        .modifier(BasicNeumorphicShadow())
                        
                        ScrollView {
                            ForEach(self.savedSaintViewModelList.filteredSaints) { saint in
                                NavigationLink(
                                    destination:
                                        DetailSavedSaint(detailSavedSaintViewModel: DetailSavedSaintViewModel(saintServerID: Int(saint.serverID)), onDelete: deleteItems),
                                    label: {
                                        SaintRow(saintName: saint.unwrappedFullName,
                                                 saintSavedImage:  saint.unwrappedFirstImage.compactMap { UIImage(data: $0) }.first )
                                            .padding()
                                    })
                                    .buttonStyle(PlainButtonStyle())
                                    .frame(width: geometry.size.width)
                                    .listRowInsets(.init())
                                
                            }
                        }.frame(width: geometry.size.width)
                    }
                }
            }
            .navigationBarHidden(true)
        }.onAppear {
            savedSaintViewModelList.updateScreen()
        }
    }
    
    private func deleteItems(saintServerID: Int) {
        withAnimation{
            savedSaintViewModelList.deleteSaint(serverID: saintServerID)
        }
    }
}
