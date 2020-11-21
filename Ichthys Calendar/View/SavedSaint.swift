//
//  SavedSaint.swift
//  Ichthys Calendar
//
//  Created by Viktor on 19.11.2020.
//

import SwiftUI
import CoreData

struct SavedSaint: View {
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \SaintCDM.timestamp, ascending: true)],
        animation: .default)
    
    private var items: FetchedResults<SaintCDM>
    
    
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
                        .frame(width: geometry.size.width, height: 35 )
                        .edgesIgnoringSafeArea(.top)
                        
                        List {
                            ForEach(items) { saint in
                                VStack {
                                    Text("Item at \(saint.fullName!)")
                                    Text("Item at \(saint.timestamp!)")
                                }
                              
                            }
                            .onDelete(perform: deleteItems)
                        }
                    }
                }
            }
        }
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)
            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}


struct SavedSaint_Previews: PreviewProvider {
    static var previews: some View {
        SavedSaint()
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()
