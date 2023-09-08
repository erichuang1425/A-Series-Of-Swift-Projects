//
//  ContentView.swift
//  Comptialize!
//
//  Created by Eric Huang on 9/26/20.
//  Copyright © 2020 Eric Huang. All rights reserved.
//

import SwiftUI

struct LobbyView: View {
    @State var highestScore = "0pt"
    @State var viewSwitchIndex = 0
    var body: some View {
        
        ZStack{
            NavigationView{
                VStack{
                    VStack{
                        HStack{
                            Text("Highest Score:")
                            Text(highestScore)
                        }
    
                        Image("LobbyImage")
                    }

                    Spacer()
                    HStack{
                        NavigationLink(destination: SecondaryLobbyView()){
                            Text("First")
                            
                        }
                        
                        Button("Second") {
                            return
                        }
                        Button("From") {
                            return
                        }
                    }
                    Spacer()
                }
            }
        }
    }
}
struct SecondaryLobbyView:View{
    var body: some View{
        ZStack{
            HStack{
                
                Button("Denary to HEX") {
                    return
                }
                Button("Denary to Binary") {
                    return
                }
                      
            }
        }
    }
    
    
}

struct GameView:View{
    var body: some View{
        ZStack{
            Text("")
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SecondaryLobbyView()
    }
}
