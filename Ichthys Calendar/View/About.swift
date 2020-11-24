//
//  About.swift
//  Ichthys Calendar
//
//  Created by Viktor on 19.11.2020.
//

import SwiftUI

struct About: View {
    @Environment(\.colorScheme) var colorScheme
    //FIXME: - Add Logic
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                colorScheme == .dark ?  Color.black : Color.white
                ZStack {
                    VStack {
                        ZStack {
                            WaveShape()
                                .fill(Color(#colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)).opacity(0.3))
                        }
                        .frame(width: geometry.size.width, height: 45)
                        .edgesIgnoringSafeArea(.top)
                        
                        Text("Ichthys Calendar")
                            .bold()
                    }
                }
            }
        }
    }
}

struct About_Previews: PreviewProvider {
    static var previews: some View {
        About()
    }
}
