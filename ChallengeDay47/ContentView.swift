//
//  ContentView.swift
//  ChallengeDay47
//
//  Created by KazukiNakano on 2020/06/25.
//  Copyright © 2020 kazu. All rights reserved.
//

import SwiftUI

struct HabitItem: Identifiable, Codable {
    let id = UUID()
    let activityName: String
    let discription: String
    let finishedAmount: Int
}

class Habits: ObservableObject {
    @Published var items: [HabitItem] {
        didSet {
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    
    init() {
        if let items = UserDefaults.standard.data(forKey: "Items") {
            let decoder = JSONDecoder()
            if let decoded = try? decoder.decode([HabitItem].self, from: items) {
                self.items = decoded
                return
            }
        }

        self.items = []
    }
}

struct ContentView: View {
    @ObservedObject var habits = Habits()
    @State private var showingAddHabit = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(habits.items) { item in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(item.activityName)
                                .font(.headline)
                        }

                        Spacer()
                        Text("\(item.finishedAmount)")
                    }
                }
                .onDelete(perform: removeItems)
            }
            .navigationBarTitle("HabitMemory")
            .navigationBarItems(trailing:
                Button(action: {
                    self.showingAddHabit = true
                }) {
                    Image(systemName: "plus")
                }
            )
        }
        .sheet(isPresented: $showingAddHabit) {
            AddView(habits: self.habits)
        }
    }
    
    func removeItems(at offsets: IndexSet) {
        habits.items.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
