//
//  DetailSaintView.swift
//  Ichthys Calendar
//
//  Created by Viktor on 09.11.2020.
//

import SwiftUI

struct DetailSaintView: View {
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.horizontalSizeClass) var sizeClass
    @StateObject var detailSaintViewModel: DetailSaintViewModel
    @State private var isFavorited = false
    @GestureState private var dragOffset = CGSize.zero
    
    //MARK: - CoreData Object
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(sortDescriptors: [], animation: .default)
    private var items: FetchedResults<SaintCDM>
    
    var backButton : some View { Button(action: {
        self.presentationMode.wrappedValue.dismiss()
    }) {
        HStack {
            if sizeClass == .compact {
                Image(systemName: "arrow.backward.square.fill")
                    .aspectRatio(contentMode: .fit)
                Text("Go back")
            } else {
                EmptyView()
            }
        }}
    }
    
    var saveButton : some View { Button(action: {
    }) {
        HStack {
            Image(systemName: "heart.circle")
                .accessibility(label: Text(isFavorited ? "removeFromFavorites" : "addToFavorites"))
                .scaleEffect(isFavorited ? 1.5 : 1.0)
                .foregroundColor(isFavorited ? Color.red : Color.gray)
                .animation(.easeInOut(duration: 0.5))
                .onTapGesture {
                    self.detailSaintViewModel.saveSaintToCoreData()
                    self.isFavorited.toggle()
                }
        }}
    .animation(.spring())
    }
    
    var headerView: some View {
        ZStack {
            if let imageURL = detailSaintViewModel.imageURL {
                BigIconImage(url: imageURL)
            } else {
                ZStack {
                    BigIconImagePlaceholder()
                    Text("No Image")
                        .font(.system(size: 45, weight: .bold, design: .default))
                }
            }
        }
    }
    
    var body: some View {
        ScrollView {
            GeometryReader { geometry in
                ZStack {
                    if geometry.frame(in: .local).minY <= 0 {
                        headerView
                            .frame(width: geometry.size.width, height: geometry.size.height)
                            .offset(y: geometry.frame(in: .local).minY / 9)
                            .clipped()
                    } else {
                        headerView
                            .frame(width: geometry.size.width, height: geometry.size.height + geometry.frame(in: .local).minY)
                            .clipped()
                            .offset(y: -geometry.frame(in: .global).minY)
                    }
                }
            }
            .frame(height: 350)
            
            Group {
                Text(detailSaintViewModel.fullName).font(.title2)
                DisclosureGroup(
                    content: {
                        Text(detailSaintViewModel.description)
                            .font(.body)
                            .fontWeight(.light)
                    },
                    label: {
                        Text("History")
                            .font(.body)
                            .bold()
                    })
                DisclosureGroup(
                    content: {
                        ForEach(self.detailSaintViewModel.canons) { canon in
                            Text(canon.unwrappedTitle)
                            Divider()
                            Text(canon.unwrappedMetaDescription)
                            Divider()
                            Text(canon.unwrappedText)
                            Divider()
                        }
                    },
                    label: {
                        Text("Canon")
                            .font(.body)
                            .bold()
                    })
                DisclosureGroup(
                    content: {
                        ForEach(self.detailSaintViewModel.prayers) { prayer in
                            Group {
                                Text(prayer.unwrappedType).bold()
                                Divider()
                                Text(prayer.unwrappedText)
                                Divider()
                            }
                        }
                    },
                    label: {
                        Text("Prayers")
                            .font(.body)
                            .bold()
                    })
            }
            .padding(.horizontal)
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarTitle(Text(detailSaintViewModel.name), displayMode: .inline)
        .navigationBarItems(leading:backButton, trailing: saveButton)
        .onAppear {
            detailSaintViewModel.getCertainSaint()
        }
        .gesture(DragGesture().updating($dragOffset, body: { (value, state, transaction) in
            if (value.startLocation.x < 20 && value.translation.width > 100) {
                self.presentationMode.wrappedValue.dismiss()
            }
        }))
    }
    

    
}
struct DetailSaintView_Previews: PreviewProvider {
    static var previews: some View {
        DetailSaintView(detailSaintViewModel: DetailSaintViewModel(saintID: 1))
    }
}
