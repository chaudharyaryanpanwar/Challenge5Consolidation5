//
//  ContentView.swift
//  Challenge5
//
//  Created by Aryan Panwar on 27/07/24.
//

import SwiftUI


struct ContentView: View {
    
    @State private var isShowingErrorMessage = false
    @State private var errorMessage = ""
    
    @State private var showingConfirmation = false
    @State private var confirmationMessage = ""
    
    @State private var users = [User]()
    
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
            let url = URL(string :  "https://www.hackingwithswift.com/samples/friendface.json")!
            var request = URLRequest(url: url)
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpMethod = "GET"
            
            do {
                let (data , _) = try await URLSession.shared.data(for: request)
                
                let decodedData = try JSONDecoder().decode([User].self, from: data)
                users = decodedData
                
                confirmationMessage = "Successfully downloaded JSON from "
                showingConfirmation = true
            } catch {
                print("Failed to get Json : \(error.localizedDescription)")
                isShowingErrorMessage = true
                errorMessage  = "No network connection"
            }
        }
    }
}

#Preview {
    ContentView()
        .preferredColorScheme(.dark)
}
