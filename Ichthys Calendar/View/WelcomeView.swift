//
//  WelcomeView.swift
//  Ichthys Calendar
//
//  Created by Viktor on 12.11.2020.
//

import SwiftUI

import SwiftUI

struct WelcomeView: View {
    var body: some View {
        ZStack {
            VStack {
                Text("Ichthys Calendar")
                    .font(.largeTitle)
                
                Text("Please select a day from the left-hand menu; swipe from the left edge to show it.")
                    .foregroundColor(.secondary)
            }
        }
    }
}


struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
