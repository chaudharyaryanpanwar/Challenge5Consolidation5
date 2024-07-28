//
//  ContentView.swift
//  Challenge5
//
//  Created by Aryan Panwar on 27/07/24.
//

import SwiftData
import SwiftUI


struct ContentView: View {
    
    @State private var isShowingErrorMessage = false
    @State private var errorMessage = ""
    
    @State private var showingConfirmation = false
    @State private var confirmationMessage = ""
    
    @Query var users : [User]
    @Environment(\.modelContext) var modelContext
    
    var body: some View {
        NavigationStack {
            VStack {
                if users.isEmpty {
                    ProgressView()
                        .progressViewStyle(.circular)
                }
                else {
                    List(users){ user in
                        NavigationLink(value : user) {
                            VStack(alignment: .leading){
                                Text(user.name)
                                    .font(.title3.bold())
                                Text("Status : \(user.isActive ? "Active" : "Not Active")")
                            }
                        }
                    }
                    .navigationDestination(for: User.self , destination: { user in
                        DetailView(user: user)
                    })
                }
            
            }
                .alert("Thank you", isPresented: $showingConfirmation) {
                    Button("Ok"){}
                } message : {
                    Text(confirmationMessage)
                }
                .alert("Oops", isPresented: $isShowingErrorMessage) {
                    Button("Try Again"){
                        Task{
                            await loadUsers()
                        }
                    }
                } message: {
                    Text(errorMessage)
                }
            .navigationTitle("Users")
        }
        .onAppear(perform: {
            Task {
                await loadUsers()
            }
        })
    }
    
    func loadUsers() async {
        if users.isEmpty {
            let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json")!
            var request = URLRequest(url: url)
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpMethod = "GET"
            
            do {
                let (data, _) = try await URLSession.shared.data(for: request)
                
                let decoder = JSONDecoder()
                
                decoder.dateDecodingStrategy = .iso8601
                
                let decodedData = try decoder.decode([User].self, from: data)
                for user in decodedData {
                    modelContext.insert(user)
                }
                
                confirmationMessage = "Successfully downloaded JSON"
                showingConfirmation = true
            } catch {
                print("Failed to get JSON: \(error.localizedDescription)")
                isShowingErrorMessage = true
                errorMessage = "Failed to load data. Please check your network connection."
            }
        }
    }

}

