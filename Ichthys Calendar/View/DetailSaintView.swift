//
//  DetailSaintView.swift
//  Ichthys Calendar
//
//  Created by Viktor on 09.11.2020.
//

import SwiftUI

struct DetailSaintView: View {
    let id: Int
    @ObservedObject var viewModel = DetailSaintViewModel()
    
    var body: some View {
        VStack {
            ScrollView {
                Text("ID: \(viewModel.saint?.unwrappedDescription ?? "")")
            }
        }
        .onAppear {
            viewModel.getCertainSaint(id: id)
        }
    }
}

struct DetailSaintView_Previews: PreviewProvider {
    static var previews: some View {
        DetailSaintView(id: 1)
    }
}
