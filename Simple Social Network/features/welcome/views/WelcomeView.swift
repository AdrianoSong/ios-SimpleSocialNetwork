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
    
    @State fileprivate var isOnLoading = false
    
    fileprivate let viewModel: WelcomViewModel
        
    var onFinish: (() -> Void)?
    
    init(viewModel: WelcomViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(
                    gradient: Gradient(colors: [.babyBlue, .blueSky]),
                    startPoint: .top,
                    endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            
                LoadingView(isShowing: $isOnLoading, content: {
                    VStack(alignment: .leading, content: {
                        //fill all screen width
                        HStack {
                            Spacer()
                        }
                        
                        Spacer()
                        
                        self.screenTitle()
                        
                        Spacer()
                        
                        self.emailInput()
                        
                        self.passwordInput()
                        
                        self.loginButon()

                        self.createAccountAndNeedHelpButtons()
                        
                        Spacer()
                        
                        Spacer()
                    })
                })
            }
        }
    }
    
    fileprivate func screenTitle() -> some View {
        return HStack {
            Spacer()
            Text("welcome.screen.title")
                .foregroundColor(.white)
                .font(.system(size: 32, weight: .medium, design: .rounded))
            Spacer()
        }
    }
    
    fileprivate func emailInput() -> some View {
        return BaseField(
            placeholder: Text("welcome.screen.email_placeholder").foregroundColor(.white),
            imageName: "person.crop.circle",
            keyboardType: .emailAddress,
            captalization: .none,
            text: $email)
    }
    
    fileprivate func passwordInput() -> some View {
        return BaseField(
            placeholder: Text("welcome.screen.user_password").foregroundColor(.white),
            imageName: "lock.fill",
            imageSizes: (width: 15, height: 20),
            imageRightSpacing: 20,
            text: $password,
            isSecureField: true)
    }
    
    fileprivate func loginButon() -> some View {
        return HStack {
            LoginButton(
                title: Text("welcome.screen.sign_in_button_title"), action: {
                    
                    self.isOnLoading = true
                    
                    self.viewModel
                        .performLogin(email: self.email, password: self.password)
                        .subscribe(onNext: { user in
                            
                            self.isOnLoading = false
                            
                            App.shared.user = user
                            
                            self.onFinish?()

                        }, onError: { error in
                            print("error to fecth user: \(error)")
                            self.isOnLoading = false
                        }).disposed(by: self.viewModel.bag)
            })
        }.padding(.top, 30)
    }
    
    fileprivate func createAccountAndNeedHelpButtons() -> some View {
        return HStack {
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
    }
    
    fileprivate func createNewAccountButton() -> Button<HStack<Text>> {
        return Button(action: {
            self.isShowingCreateAccountView.toggle()
            
        }, label: {
            HStack {
                Text("welcome.screen.create_account").foregroundColor(.white)
            }
        })
    }
    
    fileprivate func needHelpButton() -> Button<HStack<Text>> {
        return Button(action: {
            self.isShowingAlert.toggle()
        }, label: {
            HStack {
                Text("welcome.screen.need_help").foregroundColor(.white)
            }
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView(viewModel: WelcomViewModel()).environment(\.locale, .init(identifier: "en"))//pt-BR
    }
}
