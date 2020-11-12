//
//  Testing.swift
//  Ichthys Calendar
//
//  Created by Viktor on 12.11.2020.
//

//import SwiftUI
//
//struct Testing: View {
//    struct Bookmark: Identifiable {
//        let id = UUID()
//        let name: String
//        let icon: String
//        var items: [Bookmark]?
//        var dataSource: String = ""
//
//
//        static let apple = Bookmark(name: "Apple", icon: "1.circle", dataSource: """
//SwiftUI’s List has an enhanced initializer that lets us create expanding sections with child elements – they will be rendered with tappable arrows that open out to reveal children when tapped.
//o use this form of List you need to have data in a precise form: your data model should have an optional array of children that are of the same type, so you can create a tree. Normally you’re likely to load this kind of stuff from JSON or similar, but to keep things simple I’ll just paste in some hard-coded data so you can see what it ought to look like:
//""")
//        
//        static let bbc = Bookmark(name: "BBC", icon: "square.and.pencil")
//        static let swift = Bookmark(name: "Swift", icon: "bolt.fill")
//        static let twitter = Bookmark(name: "Twitter", icon: "mic")
//
//        // some example groups
//        static let example1 = Bookmark(name: "Favorites", icon: "star", items: [Bookmark.apple])
//        static let example2 = Bookmark(name: "Recent", icon: "timer", items: [Bookmark.apple, Bookmark.bbc, Bookmark.swift, Bookmark.twitter])
//    }
//
//    
//    
//    let items: [Bookmark] = [.example1, .example2]
//    
//    var body: some View {
//        List(items, children: \.items) { row in
//            VStack(alignment: .leading) {
//                HStack {
//                    Image(systemName: row.icon)
//                    Text(row.name)
//                }
//            Text(row.dataSource)
//            }
//        }
//        .listStyle(InsetGroupedListStyle())
//    }
//}
//
//struct Testing_Previews: PreviewProvider {
//    static var previews: some View {
//        Testing()
//    }
//}
//
//
//



