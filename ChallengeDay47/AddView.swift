//
//  AddView.swift
//  ChallengeDay47
//
//  Created by KazukiNakano on 2020/06/25.
//  Copyright © 2020 kazu. All rights reserved.
//

import SwiftUI

struct AddView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var habits: Habits
    @State private var activityName = ""
    @State private var discription = ""
    @State private var finishedAmount = 0
    
    var body: some View {
        NavigationView {
            Form {
                TextField("ActivityName", text: $activityName)
                TextField("Discription", text: $discription)
            }
            .navigationBarTitle("Add new habit")
            .navigationBarItems(trailing: Button("Save") {
                let item = HabitItem(activityName: self.activityName, discription: self.discription, finishedAmount: self.finishedAmount)
                self.habits.items.append(item)
                self.presentationMode.wrappedValue.dismiss()
            })
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(habits: Habits())
    }
}
