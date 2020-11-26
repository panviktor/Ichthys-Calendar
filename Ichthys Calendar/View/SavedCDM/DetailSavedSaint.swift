//
//  DetailSavedSaint.swift
//  Ichthys Calendar
//
//  Created by Viktor on 22.11.2020.
//

import SwiftUI

struct DetailSavedSaint: View {
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.horizontalSizeClass) var sizeClass
    @StateObject var detailSavedSaintViewModel: DetailSavedSaintViewModel
    @GestureState private var dragOffset = CGSize.zero
    @State private var isFavorited = true
    let onDelete: (_ saintServerID: Int) -> Void
    
    var emptyView: some View {
        ZStack {
            BigIconImagePlaceholder()
            Text("No Image")
                .font(.system(size: 45, weight: .bold, design: .default))
        }
    }
    
    var headerView: some View {
        ZStack {
            if let image = detailSavedSaintViewModel.images.first {
                BigIconImageSaved(image: image)
            } else {
                ZStack {
                    emptyView
                }
            }
        }
    }
    
    var headerScrollView: some View {
        ZStack {
            if let images = detailSavedSaintViewModel.images {
                if images.count > 1 {
                    ScrollView(.horizontal) {
                        HStack {
                            ForEach(images, id: \.self) { BigIconImageSaved(image: $0) }
                        }
                    }
                } else {
                    headerView
                }
            } else {
                emptyView
            }
        }
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
                    self.onDelete(detailSavedSaintViewModel.saintServerID)
                    self.isFavorited.toggle()
                }
        }}
    .animation(.spring())
    }
    
    var body: some View {
        ScrollView {
            headerScrollView
                .frame(height: 350)
            Group {
                Text(detailSavedSaintViewModel.fullName).font(.title2)
                DisclosureGroup(
                    content: {
                        Text(detailSavedSaintViewModel.description)
                            .font(.body)
                            .fontWeight(.light)
                    },
                    label: {
                        Text("History")
                            .font(.body)
                            .bold()
                    }).onAppear {
                        detailSavedSaintViewModel.fetchSaint()
                    }
                DisclosureGroup(
                    content: {
                        ForEach(self.detailSavedSaintViewModel.canons) { canon in
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
                        ForEach(self.detailSavedSaintViewModel.prayers) { prayer in
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
        .navigationBarTitle(Text(detailSavedSaintViewModel.name), displayMode: .inline)
        .navigationBarItems( trailing: saveButton)
    }
}
