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
    
    
    var body: some View {
        ScrollView {
            GeometryReader { geometry in
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
                .frame(width: geometry.size.width, height: geometry.size.height)
            }

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
        .edgesIgnoringSafeArea(.bottom)
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
