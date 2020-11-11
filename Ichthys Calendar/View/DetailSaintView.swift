//
//  DetailSaintView.swift
//  Ichthys Calendar
//
//  Created by Viktor on 09.11.2020.
//

import SwiftUI

struct DetailSaintView: View {
    @ObservedObject var detailSaintViewModel: DetailSaintViewModel
    
    
    init(detailSaintViewModel: DetailSaintViewModel) {
        self.detailSaintViewModel = detailSaintViewModel
    }
    
    var body: some View {
        VStack {
            ScrollView {
                Text("")
            }
        }
    }
}

struct DetailSaintView_Previews: PreviewProvider {
    static var previews: some View {
        DetailSaintView(detailSaintViewModel: DetailSaintViewModel(saintID: 1))
    }
}
