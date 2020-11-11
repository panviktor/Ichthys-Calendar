//
//  MainImagePlaceholder.swift
//  Ichthys Calendar
//
//  Created by Viktor on 11.11.2020.
//

import SwiftUI

struct MainImagePlaceholder: View {
    var body: some View {
        Image(systemName: "person.crop.square")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 150, height: 150, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            .foregroundColor(Color.init(#colorLiteral(red: 1, green: 0.8323456645, blue: 0.4732058644, alpha: 1)))
    }
}
