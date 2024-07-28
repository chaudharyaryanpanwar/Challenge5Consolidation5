//
//  DetailView.swift
//  Challenge5
//
//  Created by Aryan Panwar on 28/07/24.
//

import SwiftUI

struct DetailView: View {
    
    let user : User
    
    var body: some View {
//        ScrollView {
            Form {
                Section {
//                    Text("id : \(user.id)")
                    Text("Age : \(user.age)")
                    Text("Email : \(user.email)")
                    HStack {
                        Text("Registation Date : ")
                        Text(user.registered , format: .dateTime.day().month().year().hour() )
                    }
                    Text("Address : \(user.address)")
                }
                
                
                Section {
                    Text("Status : \(user.isActive ? "Active" : "Not Active")")
                    Text("About : \(user.about)")
                    Text("Company : \(user.company)")
                }
                
                
                Section ("Tags"){
                    ScrollView(.horizontal) {
                        HStack {
                            ForEach(user.tags , id : \.self){ tag in
                                Text(tag)
                                    .padding(8)
                                    .background(Color.accentColor)
                                    .foregroundStyle(.white)
                                    .clipShape(.rect(cornerRadius: 10))
                            }
                        }
                    }
                    
                }
                
                Section("Friends"){
                    ScrollView(.horizontal){
                        HStack(alignment: .center) {
                            ForEach(user.friends , id : \.id){ friend in
                                Text(friend.name)
                                    .font(.title3)
                                    .padding()
                                    .foregroundStyle(.white)
                                    .background(Color.accentColor)
                                    .clipShape(.rect(cornerRadius: 10))
                            }
                        }
                    }
                }
                
                
                
            }
//        }
        .navigationTitle(user.name)
    }
}


