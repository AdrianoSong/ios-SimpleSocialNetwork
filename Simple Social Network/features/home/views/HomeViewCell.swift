//
//  HomeViewCell.swift
//  Simple Social Network
//
//  Created by Adriano Song on 18/02/20.
//  Copyright © 2020 Adriano Song. All rights reserved.
//

import Foundation
import SwiftUI

struct HomeViewCell: View {
    
    var post: Post
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 16, content: {
                Text(post.title ?? "")
                    .font(Font.system(size: 18, weight: .medium, design: .rounded))
                    .foregroundColor(.black).padding(.top, 16).padding(.leading, 16)
                
                Text("created at: \(post.createdAt ?? "")")
                    .font(Font.system(size: 16, weight: .light, design: .rounded))
                    .foregroundColor(.gray).padding(.leading, 16)
                
                Spacer()
                
                Text(post.body ?? "")
                    .font(Font.system(size: 16, weight: .medium, design: .rounded))
                    .foregroundColor(.gray).padding(.bottom, 16).padding(.leading, 16)
            })
            
            Spacer()
            
        }
    }
}
