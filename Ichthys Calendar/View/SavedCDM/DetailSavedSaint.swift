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
            Text(NSLocalizedString("No Image", comment: ""))
                .font(.system(size: 45, weight: .bold, design: .default))
        }
    }
    
    var backButton : some View { Button(action: {
        self.presentationMode.wrappedValue.dismiss()
    }) {
        HStack {
            if sizeClass == .compact {
                Image(systemName: "arrow.backward.square.fill")
                    .aspectRatio(contentMode: .fit)
                Text(NSLocalizedString("Go back", comment: ""))
            } else {
                EmptyView()
            }
        }}
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
                .accessibility(label: Text(isFavorited ? NSLocalizedString("Remove from Favorites", comment: "") : NSLocalizedString("Add to Favorites", comment: "")))
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
                        Text(NSLocalizedString("History", comment: ""))
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
                        Text(NSLocalizedString("Canon", comment: ""))
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
                        Text(NSLocalizedString("Prayers", comment: ""))
                            .font(.body)
                            .bold()
                    })
            }
            .padding(.horizontal)
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarTitle(Text(detailSavedSaintViewModel.name), displayMode: .inline)
        .navigationBarItems(leading:backButton, trailing: saveButton)
        .gesture(DragGesture().updating($dragOffset, body: { (value, state, transaction) in
            if (value.startLocation.x < 20 && value.translation.width > 100) {
                self.presentationMode.wrappedValue.dismiss()
            }
        }))
    }
}
