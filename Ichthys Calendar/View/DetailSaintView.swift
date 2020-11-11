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
    @ObservedObject var detailSaintViewModel: DetailSaintViewModel
    @State private var isFavorited = false
    
    init(detailSaintViewModel: DetailSaintViewModel) {
        self.detailSaintViewModel = detailSaintViewModel
    }
    
    var backButton : some View { Button(action: {
        self.presentationMode.wrappedValue.dismiss()
    }) {
        HStack {
            Image(systemName: "arrow.backward.square.fill")
                .aspectRatio(contentMode: .fit)
            Text("Go back")
        }}
    }
    
    var saveButton : some View { Button(action: {
        print("Save")
    }) {
        HStack {
            Image(systemName: "heart.circle")
                .accessibility(label: Text(isFavorited ? "removeFromFavorites" : "addToFavorites"))
                .scaleEffect(isFavorited ? 1.5 : 1.0)
                .foregroundColor(isFavorited ? Color.red : Color.gray)
                .animation(.easeInOut(duration: 0.5))
                .onTapGesture {
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
                    if geometry.frame(in: .global).minY <= 0 {
                        headerView
                        .frame(width: geometry.size.width, height: geometry.size.height)
                        .offset(y: geometry.frame(in: .global).minY/9)
                        .clipped()
                    } else {
                        headerView
                        .frame(width: geometry.size.width, height: geometry.size.height + geometry.frame(in: .global).minY)
                        .clipped()
                        .offset(y: -geometry.frame(in: .global).minY)
                    }
                }
            }
            .frame(height: 350)
            

            VStack(alignment: .leading, spacing: 16) {
                VStack(alignment: .leading, spacing: 5) {
                    Text(detailSaintViewModel.fullName).font(.title2)
                    Text("Description").font(.title)
                    Text(detailSaintViewModel.description).font(.subheadline)
                        .lineLimit(nil)
                    
                    Text("History").font(.title)
                    Text(detailSaintViewModel.metaDescription).font(.subheadline)
                        .lineLimit(nil)
                    
                }.padding(.horizontal)
            }
        }
        .navigationBarTitle(Text(detailSaintViewModel.name), displayMode: .inline)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: backButton, trailing: saveButton)
        .onAppear {
            detailSaintViewModel.getCertainSaint()
        }
    }
}
struct DetailSaintView_Previews: PreviewProvider {
    static var previews: some View {
        DetailSaintView(detailSaintViewModel: DetailSaintViewModel(saintID: 1))
    }
}
