//
//  ContentView.swift
//  Simple Social Network
//
//  Created by Adriano Song on 07/02/20.
//  Copyright © 2020 Adriano Song. All rights reserved.
//

import SwiftUI

struct WelcomeView: View {
    
    @State fileprivate var email: String = ""
    @State fileprivate var password: String = ""
    
    @State fileprivate var isShowingCreateAccountView = false
    @State fileprivate var isShowingAlert = false
    @State fileprivate var isPushToHomeView = false
    
    var viewModel = WelcomViewModel()
            
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(
                    gradient: Gradient(colors: [.babyBlue, .blueSky]),
                    startPoint: .top,
                    endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            
                VStack(alignment: .leading, content: {
                    //fill all screen width
                    HStack {
                        Spacer()
                    }
                    
                    Spacer()
                    
                    ScreenTitle()
                    
                    Spacer()
                    
                    emailInput()
                    
                    passwordInput()
                    
                    NavigationLink(destination: HomeView(), isActive: $isPushToHomeView, label: {
                        loginButon()
                    })
                    
                    HStack {
                        createNewAccountButton().sheet(isPresented: $isShowingCreateAccountView) {
                            CreateAccountView()
                        }
                        
                        Spacer()
                        
                        needHelpButton().alert(isPresented: $isShowingAlert, content: {
                            Alert(title: Text("welcome.screen.need_help"),
                                  message: Text("welcome.screen.contat_song"),
                                  dismissButton: .default(Text("welcome.screen.okey_button_title")
                                )
                            )
                        })
                        
                    }.padding(.all, 16)
                    
                    Spacer()
                })
            }
        }
    }
    
    fileprivate func ScreenTitle() -> some View {
        return HStack {
            Spacer()
            Text("welcome.screen.title")
                .foregroundColor(.white)
                .font(.system(size: 32, weight: .medium, design: .rounded))
            Spacer()
        }
    }
    
    fileprivate func emailInput() -> some View {
        return HStack(spacing: 16) {
            Image(systemName: "person.crop.circle")
                .resizable()
                .frame(width: 25, height: 25)
                .foregroundColor(.white)
                .padding(.leading, 25)
            CustomEmailField(
                placeholder: Text("welcome.screen.email_placeholder").foregroundColor(.white),
                text: $email)
        }
        .frame(minWidth: 0, maxWidth: .infinity, maxHeight: 50)
        .background(Color.blueBG)
        .cornerRadius(40)
        .padding(.horizontal, 16)
    }
    
    fileprivate func passwordInput() -> some View {
        return HStack(spacing: 16) {
            Image(systemName: "lock.fill")
                .resizable()
                .frame(width: 20, height: 25)
                .foregroundColor(.white)
                .padding(.leading, 30)
            CustomPasswordField(
                placeholder: Text("welcome.screen.user_password").foregroundColor(.white),
                text: $password)
        }
        .frame(minWidth: 0, maxWidth: .infinity, maxHeight: 50)
        .background(Color.blueBG)
        .cornerRadius(40)
        .padding(.horizontal, 16)
    }
    
    fileprivate func loginButon() -> some View {
        return HStack {
            LoginButton(
                title: Text("welcome.screen.sign_in_button_title"), action: {
                    
                    self.viewModel
                        .performLogin(email: self.email, password: self.password)
                        .subscribe(onNext: { user in
                            self.isPushToHomeView.toggle()
                            print("success login!: \(user)")
                        }, onError: { error in
                            print("error to fecth user: \(error)")
                        }).disposed(by: self.viewModel.bag)
            })
        }.padding(.top, 30)
    }
    
    fileprivate func createNewAccountButton() -> Button<HStack<Text>> {
        return Button(action: {
            self.isShowingCreateAccountView.toggle()
            
        }) {
            HStack {
                Text("welcome.screen.create_account").foregroundColor(.white)
            }
        }
    }
    
    fileprivate func needHelpButton() -> Button<HStack<Text>> {
        return Button(action: {
            self.isShowingAlert.toggle()
        }) {
            HStack {
                Text("welcome.screen.need_help").foregroundColor(.white)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView().environment(\.locale, .init(identifier: "en"))//pt-BR
    }
}
