//
//  Challenge5App.swift
//  Challenge5
//
//  Created by Aryan Panwar on 27/07/24.
//

import SwiftData
import SwiftUI

@main
struct Challenge5App: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: User.self)
    }
}
