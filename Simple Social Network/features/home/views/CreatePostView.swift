//
//  CreatePostView.swift
//  Simple Social Network
//
//  Created by Adriano Song on 20/02/20.
//  Copyright © 2020 Adriano Song. All rights reserved.
//

import Foundation
import SwiftUI

struct CreatePostView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State fileprivate var isShowingLoading = false
    @State fileprivate var postTitle: String = ""
    @State fileprivate var postBody: String  = ""
    
    var postCreated: ((Post) -> Void)?
    
    @Binding var isPresented: Bool
    let viewModel: HomeViewModel
    
    var body: some View {
        
        VStack {
            headerView()
            
            Divider()
            
            postForm()
            
            Spacer()
        }.background(Color.grayBG)
    }
        
    fileprivate func headerView() -> some View {
        return HStack {
            cancelButton()
            
            Spacer()
            
            Text("create.post.screen.title")
            
            Spacer()
            
            addPostButton()
        }.padding(.all, 16)
    }
        
    fileprivate func cancelButton() -> Button<Text> {
        return Button(action: {
            self.isPresented = false
            self.presentationMode.wrappedValue.dismiss()
            
        }, label: {
            Text("create.post.screen.cancel_button")
        })
    }
    
    fileprivate func addPostButton() -> Button<Text> {
        return Button(action: {
            
            self.viewModel.createPost(
                title: self.postTitle, postDescription: self.postBody, userId: App.shared.user?.id)
                .subscribe(onNext: { post in
                    self.postCreated?(post)
                    self.isPresented = false
                    self.presentationMode.wrappedValue.dismiss()
                    
                }, onError: { error in
                    print("create post error \(error)")
                }).disposed(by: self.viewModel.bag)
            
        }, label: {
            Text("create.post.screen.post_button")
        })
    }
    
    fileprivate func postForm() -> some View {
        return Form {
            Section(header: Text("create.post.screen.post_section_title"), content: {
                TextField("create.post.screen.post_title", text: $postTitle)
            })
            Section(header: Text("create.post.screen.post_section_description"), content: {
                TextField("create.post.screen.post_description", text: $postBody)
                    .foregroundColor(.black)
                    .fixedSize()
                    .frame(height: 200, alignment: .topLeading)
            })
        }.padding(.horizontal, 16)
    }
}
