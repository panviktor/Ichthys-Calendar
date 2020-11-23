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
    
    //    var headerView: some View {
    //        ZStack {
    //            if let imageURL = detailSavedSaintViewModel.imageURL {
    //                BigIconImage(url: imageURL)
    //            } else {
    //                ZStack {
    //                    BigIconImagePlaceholder()
    //                    Text("No Image")
    //                        .font(.system(size: 45, weight: .bold, design: .default))
    //                }
    //            }
    //        }
    //    }
    //
    //    var headerScrollView: some View {
    //        ZStack {
    //            if let imageURLs = detailSavedSaintViewModel.imageURLArray {
    //                if imageURLs.count > 1 {
    //                    ScrollView(.horizontal) {
    //                        HStack {
    //                            ForEach(imageURLs, id: \.self) { BigIconImage(url: $0) }
    //                        }
    //                    }
    //                } else {
    //                    headerView
    //                }
    //            } else {
    //                ZStack {
    //                    BigIconImagePlaceholder()
    //                    Text("No Image")
    //                        .font(.system(size: 45, weight: .bold, design: .default))
    //                }
    //            }
    //        }
    //    }
    
    var body: some View {
        ScrollView {
            //            GeometryReader { geometry in
            //                HStack {
            //
            
            //                    ForEach(self.detailSavedSaintViewModel.images, id: \.self) { img in
            //                        Image(uiImage: img)
            //                    }
            
            
            
            
            
            //                        headerScrollView
            //                            .frame(width: geometry.size.width, height: geometry.size.height)
            //                            .clipped()
            //                            .offset(y: geometry.frame(in: .local).minY / 9)
            
            //                }
            //            }
            //            .frame(height: 350)
            //
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
        
        //     .navigationBarItems(leading:backButton, trailing: saveButton)
    }
}
