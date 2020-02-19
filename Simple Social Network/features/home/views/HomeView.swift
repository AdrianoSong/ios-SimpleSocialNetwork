//
//  HomeView.swift
//  Simple Social Network
//
//  Created by Adriano Song on 12/02/20.
//  Copyright © 2020 Adriano Song. All rights reserved.
//

import Foundation
import SwiftUI

struct HomeView: View {
    
    var onFinish: (() -> Void)?
    
    var posts = [Post]()
        
    init() {
        setListProperties()
        
        createFakeData()
    }
    
    fileprivate func setListProperties() {
        // To remove only extra separators below the list:
        UITableView.appearance().tableFooterView = UIView()
        // To remove all separators including the actual ones:
        UITableView.appearance().separatorStyle = .none
        UITableView.appearance().backgroundColor = .grayBG
    }
    
    fileprivate mutating func createFakeData() {
        posts.append(
            Post(createdAt: "ontem",
                 updatedAt: "hoje",
                 id: 1, title: "title 1",
                 body: "body 1",
                 postOwner: App.shared.user)
        )
        
        posts.append(
            Post(createdAt: "ontem",
                 updatedAt: "hoje",
                 id: 2, title: "title 2",
                 body: "body 2",
                 postOwner: App.shared.user)
        )
        
        posts.append(
            Post(createdAt: "ontem",
                 updatedAt: "hoje",
                 id: 3, title: "title 3",
                 body: "body 3",
                 postOwner: App.shared.user)
        )
    }
    
    var body: some View {
        
        NavigationView {
            List(posts) { post in
                HomeViewCell(post: post).background(Color.white).cornerRadius(10).shadow(radius: 10)
            }
            //navigation bar items
            .navigationBarItems(leading:
                HStack {
                    Button(action: {
                        self.onFinish?()
                    
                    }, label: {
                        Text("home.screen.logout")
                            .font(Font.system(size: 18, weight: .medium, design: .rounded))
                            .foregroundColor(.red)
                    })
                }, trailing:
                HStack {
                    Button(action: {}, label: {
                        Text("home.screen.new_post")
                            .font(Font.system(size: 18, weight: .medium, design: .rounded))
                            .foregroundColor(.blue)
                    })
                })
            //navigation title bar
            .navigationBarTitle(Text("\(App.shared.user?.name ?? "")'s ") + Text("home.screen.title"))
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView().environment(\.locale, .init(identifier: "en"))//pt-BR
    }
}
