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
    
    @ObservedObject var viewModel: HomeViewModel
    
    @State fileprivate var isShowLoading = false
        
    init(viewModel: HomeViewModel) {
        
        self.viewModel = viewModel
        
        getPosts()
        
        setListProperties()
    }
    
    fileprivate func getPosts() {
        isShowLoading = true
        self.viewModel.getPosts().subscribe(onNext: { posts in
            self.isShowLoading = false
            self.viewModel.posts = posts
        }, onError: { (error) in
            print("getPosts on error \(error)")
            self.isShowLoading = false
        }).disposed(by: viewModel.bag)
    }
    
    fileprivate func setListProperties() {
        // To remove only extra separators below the list:
        UITableView.appearance().tableFooterView = UIView()
        // To remove all separators including the actual ones:
        UITableView.appearance().separatorStyle = .none
        UITableView.appearance().backgroundColor = .grayBG
    }
    
    var body: some View {
        
        LoadingView(isShowing: $isShowLoading, content: {
            NavigationView {
                
                self.showPosts()
                
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
        })
    }
    
    fileprivate func showPosts() -> some View {
        
        if viewModel.posts.isEmpty {
            return AnyView(HomeViewCellEmpty())
        
        } else {
            return AnyView(List(self.viewModel.posts) { post in
                HomeViewCell(post: post)
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(radius: 5)
            })
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(viewModel: HomeViewModel()).environment(\.locale, .init(identifier: "en"))//pt-BR
    }
}
