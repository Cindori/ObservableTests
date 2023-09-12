//
//  ObservableTestsApp.swift
//  ObservableTests
//
//  Created by Oskar Groth on 2023-09-12.
//

import SwiftUI
import Observation

@main
struct ObservableTestsApp: App {
    let observableUser = ObservableUser()
    let observableObjectUser = ObservableObjectUser()
    
    var body: some Scene {
        WindowGroup {
            VStack(spacing: 40) {
                Text("Compare the debugger log output when editing Age using the different methods")
                HStack(spacing: 100) {
                    VStack {
                        Text("ObservableObject")
                        ObservableObjectAgePicker(user: observableObjectUser)
                        ObservableObjectStreetPicker(user: observableObjectUser)
                    }
                    VStack {
                        Text("New @Observable")
                        ObservableAgePicker(user: observableUser)
                        ObservableStreetPicker(user: observableUser)
                    }
                }
            }
            .padding(30)
        }
    }
}

// MARK: Observable Implementation

@Observable
class ObservableUser {
    var age: Float = 0
    var street: String = ""
}

struct ObservableAgePicker: View {
    @Bindable var user: ObservableUser
    
    var body: some View {
        Slider(value: $user.age, label: { Text("Age") })
    }
}

struct ObservableStreetPicker: View {
    @Bindable var user: ObservableUser

    var body: some View {
        Self._printChanges()
        return TextField("Street", text: $user.street)
    }
}

// MARK: ObservableObject Implementation

class ObservableObjectUser: ObservableObject {
    @Published var age: Float = 0
    @Published var street: String = ""
}

struct ObservableObjectAgePicker: View {
    @ObservedObject var user: ObservableObjectUser
    
    var body: some View {
        Slider(value: $user.age, label: { Text("Age") })
    }
}

struct ObservableObjectStreetPicker: View {
    @ObservedObject var user: ObservableObjectUser
    
    var body: some View {
        Self._printChanges()
        return TextField("Street", text: $user.street)
    }
}
