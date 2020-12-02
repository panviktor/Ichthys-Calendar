//
//  WelcomeView.swift
//  Ichthys Calendar
//
//  Created by Viktor on 12.11.2020.
//

import SwiftUI

struct WelcomeView: View {
    var body: some View {
        ZStack {
            VStack {
                Text(NSLocalizedString("Ichthys Calendar", comment: ""))
                    .font(.largeTitle)
                
                Text(NSLocalizedString("Please select a day from the left-hand menu; swipe from the left edge to show it.", comment: ""))
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
