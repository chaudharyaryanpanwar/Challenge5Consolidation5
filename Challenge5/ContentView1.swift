//
//  ContentView1.swift
//  Challenge5
//
//  Created by Aryan Panwar on 28/07/24.
//

import SwiftUI

//struct User: Codable, Identifiable {
//    let id: String
//    let isActive: Bool
//    let name: String
//    let age: Int
//    let company: String
//    let email: String
//    let address: String
//    let about: String
//    let registered: String
//    let tags: [String]
//    let friends: [Friend]
//}
//
//struct Friend: Codable {
//    let id: String
//    let name: String
//}
struct ContentView1 : View {
    
    @State private var isShowingErrorMessage = false
    @State private var errorMessage = ""
    
    @State private var showingConfirmation = false
    @State private var confirmationMessage = ""
    
    @State private var response = [User]()
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            
            Text("Hello, world!")
                .font(.largeTitle)
                .padding()
            
            // Display data in a List
            List(response) { user in
                VStack(alignment: .leading) {
                    Text(user.name)
                        .font(.headline)
                    Text(user.email)
                        .font(.subheadline)
                }
            }
            .alert("Thank you", isPresented: $showingConfirmation) {
                Button("Ok") {}
            } message: {
                Text(confirmationMessage)
            }
            .alert("Oops", isPresented: $isShowingErrorMessage) {
                Button("Try Again") {
                    Task {
                        await loadUsers()
                    }
                }
            } message: {
                Text(errorMessage)
            }
        }
        .padding()
        .onAppear {
            Task {
                await loadUsers()
            }
        }
    }
    
    func loadUsers() async {
        
        let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "GET"
        
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            let decodedData = try JSONDecoder().decode([User].self, from: data)
            response = decodedData
            confirmationMessage = "Successfully downloaded JSON from the server"
            showingConfirmation = true
        } catch {
            print("Failed to get JSON: \(error.localizedDescription)")
            isShowingErrorMessage = true
            errorMessage = "Failed to load data. Please check your network connection."
        }
    }
}

#Preview {
    ContentView1()
        .preferredColorScheme(.dark)
}
