//
//  MainScreen.swift
//  CryptoTracker
//
//  Created by Aleksandra on 17.01.2024.
//

import SwiftUI

struct MainScreen: View {
    @State var selectedTab = "Home"
    @State var showMenu = false
    
    @Namespace var animation
    
    var body: some View {
        ZStack{
            Color(.blue)
                .ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 15,
                   content: {
                
                Image(systemName: "person.crop.circle")
                    .resizable()
                    .aspectRatio(contentMode:
                            .fill)
                    .frame(width: Constants.avatarImageHeight,
                           height: Constants.avatarImageHeight)
                    .padding (.top, 50)
                
                VStack(alignment: .leading, spacing: 6,
                       content: {
                    Text ("Jenna Ezarik")
                        .font(.title)
                        .fontWeight (.heavy)
                        .foregroundColor (.white)
                    Button(action: {}, label: {
                        Text ("View Profile")
                            .fontWeight(.semibold)
                            .foregroundColor (.white)
                            .opacity (0.7)
                    })
                })
                
                VStack(alignment: .leading,
                       spacing: 10, content: {
                    TabButton(image: "house",
                              title: "Home",
                              animation: animation,
                              selectedTab: $selectedTab)
                    
                    TabButton(image: "clock.arrow.circlepath",
                              title: "History",
                              animation: animation,
                              selectedTab: $selectedTab)
                    
                    TabButton(image: "bitcoinsign.arrow.circlepath",
                              title: "Coin",
                              animation: animation,
                              selectedTab: $selectedTab)
                    
                    TabButton(image: "gearshape",
                              title: "Settings",
                              animation: animation,
                              selectedTab: $selectedTab)
                    
                    TabButton(image: "questionmark.circle",
                              title: "Help",
                              animation: animation,
                              selectedTab: $selectedTab)
                })
                .padding(.leading, -15)
                .padding(.top, 50)
                
                Spacer()
                
                TabButton(image:
                            "rectangle.righthalf.inset.fill.arrow.right", 
                          title: "Log out",
                          animation: animation,
                          selectedTab: .constant(""))
                .padding (.leading, -15)
            })
            .padding()
            .frame(maxWidth: .infinity,
                   maxHeight: .infinity,
                   alignment: .topLeading)
            
            ZStack() {
                Color.white
                    .opacity(0.5)
                    .cornerRadius(showMenu ? 15 : 0)
                    .shadow(color: .black.opacity(0.5), radius: 5, x: -5, y: 0)
                    .offset(x: showMenu ? -25 : 0)
                    .padding(.vertical, 30)
                
                Color.white
                    .opacity(0.4)
                    .cornerRadius(showMenu ? 15 : 0)
                    .shadow(color: .black.opacity(0.5), radius: 5, x: -5, y: 0)
                    .offset(x: showMenu ? -50 : 0)
                    .padding(.vertical, 60)
                
                Home(selectedTab: $selectedTab)
                    .cornerRadius(showMenu ? 15 : 0)
            }
            
            .scaleEffect(showMenu ? 0.84 : 1)
            .offset(x: showMenu ? getRect().width - 120 : 0)
            .ignoresSafeArea()
            .overlay(
                Button(action: {
                    withAnimation(.spring()){ showMenu.toggle() }
                }, label: {
                    VStack(spacing: 5){
                        Capsule()
                            .fill(showMenu ? Color.white : Color.primary)
                            .frame(width: 30, height: 3)
                            .rotationEffect(.init(degrees: showMenu ? -50 : 0))
                            .offset(x: showMenu ? 2 : 0,
                                    y: showMenu ? 9 : 0)
                        VStack(spacing: 5, content: {
                            Capsule()
                                .fill(showMenu ? Color.white : Color.primary)
                                .frame(width: 30, height: 3)
                            
                            Capsule()
                                .fill(showMenu ? Color.white : Color.primary)
                                .frame(width: 30, height: 3)
                                .offset(y: showMenu ? -8 : 0)
                        })
                        
                        .rotationEffect(.init(degrees: showMenu ? 50 : 0))
                    }
                })
                .padding()
                ,alignment: .topLeading
            )
        }
    }
}

// MARK: - TabButton
struct TabButton: View {
    var image: String
    var title: String
    var animation: Namespace.ID
    
    @Binding var selectedTab: String
    
    var body: some View {
        Button(action: {
            withAnimation(.spring()){ selectedTab = title }
        }, label: {
            HStack(spacing: 15){
                Image (systemName: image)
                    .font(.title2)
                    .frame(width: Constants.tabButtonImageWidth)
                Text(title)
                    .fontWeight (.semibold)
            }
            .foregroundColor (selectedTab ==  title ?
                              Color(.blue) : .white)
            .padding (.vertical,12)
            .padding (.horizontal, 10)
            .frame(maxWidth: getRect().width - 170, alignment: .leading)
            .background (
                ZStack(content: {
                    if selectedTab == title {
                        Color.white
                            .opacity(selectedTab == title ? 1: 0)
                            .clipShape(CustomCorners(corners: [.topRight, .bottomRight],
                                                     radius: 10))
                            .matchedGeometryEffect(id: "TAP", in: animation)
                    }
                })
            )
        })
    }
}

struct Constants {
    static let avatarImageHeight: CGFloat = 70
    static let tabButtonImageWidth: CGFloat = 30
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainScreen()
    }
}
