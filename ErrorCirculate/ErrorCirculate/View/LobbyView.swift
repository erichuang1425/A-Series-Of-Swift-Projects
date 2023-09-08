//
//  ContentView.swift
//  ErrorCirculate
//
//  Created by Eric Huang on 10/8/20.
//  Copyright © 2020 Eric Huang. All rights reserved.
//

import SwiftUI

struct LobbyView: View {

    var destination:AnyView{
        get{
            if isAppAlreadyLaunchedOnce(){
                return AnyView(GameView())
            }else{
                return AnyView(Tutorial())
            }
        }
    }
    var body: some View {
        ZStack{
            NavigationView{
                NavigationLink(destination: destination){
                    Text("Enter Game")
                }
            }
        }
    }
}

struct GameView: View {
    
    var body: some View {
        Text("Hello, World!")
        
    }
}

struct GameOverView: View {
    var body: some View {
        Text("Hello, World!")
    }
}

struct Tutorial: View {
    let dataModel = DataModel()
    @State var messageIndex = 0
    var body: some View{
        ZStack{
            
            Image("Tutorial UI")
            .resizable()
            .scaledToFill()
            .overlay(
                VStack(spacing:30){
                        VStack(spacing:30){
                            
                            
                            
                            Text(dataModel.tutorialMessage[messageIndex][0])
                            .fontWeight(.black)
                            .font(.largeTitle)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
                            
                            Text("Next")
                            .foregroundColor(.blue)
                            .fontWeight(.black)
                            .onTapGesture(count:1) {
                                    
                                if self.messageIndex != 4{
                                        self.messageIndex += 1
                                }else{
                                        self.messageIndex = 0
                                }
                            }
                            
                        }
                        
                        Text(dataModel.tutorialMessage[messageIndex][1])
                            .font(.title)
                        
                    Image(dataModel.tutorialMessage[messageIndex][0])
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        Spacer()
                        
                    }.padding(.horizontal, 48)
                    .padding(.top, 50)
                        
                    
                    
                    
            )
            
        }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0,  maxHeight: .infinity, alignment: .center)
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Tutorial().previewDevice("iPhone 11")
    }
}


func isAppAlreadyLaunchedOnce() -> Bool {
    let defaults = UserDefaults.standard
    if let _ = defaults.string(forKey: "isAppAlreadyLaunchedOnce") {
        print("App already launched")
        return true
    } else {
        defaults.set(true, forKey: "isAppAlreadyLaunchedOnce")
        print("App launched first time")
        return false
    }
}
