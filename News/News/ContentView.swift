//
//  ContentView.swift
//  News
//
//  Created by Eric Huang on 5/23/20.
//  Copyright © 2020 Eric Huang. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var networkManager = NetworkManager()
    @State private var showingModal = false
    @State var textField:String = ""
    var body: some View {
        ZStack{
            NavigationView{
                List(networkManager.posts){ post in
                    Text(post.title)
                    
                }
                .navigationBarTitle("Eric News")
                .navigationBarItems(trailing: Button("+"){
                    self.showingModal = true
                })
                    .aspectRatio(contentMode: .fill)
            }
            
            if $showingModal.wrappedValue {
                // But it will not show unless this variable is true
                ZStack {
                    Color.black.opacity(0.4)
                        .edgesIgnoringSafeArea(.vertical)
                    // This VStack is the popup
                    VStack(spacing: 20) {
                        Spacer()
                        HStack {
                            Text("Message:")
                                .bold().padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.orange)
                                .foregroundColor(Color.white)
                            TextField("Enter message...", text:$textField)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .frame(width: 150, height: 30)
                          
                        }.padding(.all)
                        Spacer()
                        Button(action: {
                            self.showingModal = false
                            self.networkManager.fetchMessage(message: self.textField)
                        }) {
                            Text("Close")
                        }.padding()
                    }
                    .frame(width: 300, height: 200)
                    .background(Color.white)
                    .cornerRadius(20).shadow(radius: 20)
                }
            }
        }

    }
}
struct Post:Identifiable{
    let id:String
    let title:String
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
