//
//  DetailSaintView.swift
//  Ichthys Calendar
//
//  Created by Viktor on 09.11.2020.
//

import SwiftUI

struct DetailSaintView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var detailSaintViewModel: DetailSaintViewModel
    var saveAction:  (() -> Void)? = nil
    
    init(detailSaintViewModel: DetailSaintViewModel) {
        self.detailSaintViewModel = detailSaintViewModel
    }
    
    var backBack : some View { Button(action: {
        saveAction?()
    }) {
        HStack {
            Image(systemName: "arrow.backward.square.fill")
                .aspectRatio(contentMode: .fit)
            Text("Go back")
        }}
    }
    
    var save : some View { Button(action: {
        self.presentationMode.wrappedValue.dismiss()
    }) {
        HStack {
            Image(systemName: "person.crop.circle.fill.badge.plus")
                .aspectRatio(contentMode: .fit)
        }}
    }
    
    
    
    var body: some View {
        Text("C")
            .navigationBarTitle(Text(detailSaintViewModel.name), displayMode: .inline)
            .edgesIgnoringSafeArea(.bottom)
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: backBack)
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
