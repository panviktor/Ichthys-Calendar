//
//  RadioView.swift
//  Ichthys Calendar
//
//  Created by Viktor on 19.12.2020.
//

import SwiftUI

struct RadioView: View {
    @StateObject var viewModel: RadioViewViewModel
    
    var body: some View {
        VStack {
            VolumeSlider()
                .frame(height: 40)
                .padding(.horizontal)
        }
        .padding()
    }
}

struct RadioView_Previews: PreviewProvider {
    static var previews: some View {
        RadioView(viewModel: RadioViewViewModel())
    }
}
