//
//  CreateAccountView.swift
//  Simple Social Network
//
//  Created by Adriano Song on 12/02/20.
//  Copyright © 2020 Adriano Song. All rights reserved.
//

import Foundation
import SwiftUI

struct CreateAccountView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State fileprivate var name: String = ""
    @State fileprivate var email: String = ""
    @State fileprivate var password: String = ""
    @State fileprivate var confirmPassword: String = ""
    
    @State fileprivate var isShowingHelp = false
    @State fileprivate var isShowingTerms = false
    @State fileprivate var isShowingErrorAlert = false
    @State fileprivate var isFailtToMatchPassword = false
    @State fileprivate var isOnLoading = false
    
    fileprivate let viewModel = CreateAccountViewModel()
    
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [.babyBlue, .blueSky]),
                startPoint: .top,
                endPoint: .bottom)
            .edgesIgnoringSafeArea(.all)
            
            LoadingView(isShowing: $isOnLoading, content: {
                VStack(spacing: 16, content: {
                    
                    Spacer()
                    
                    self.defineScreenTitle()
                    
                    self.defineNameField()
                    
                    self.defineEmailField()
                    
                    self.definePasswordField()
                    
                    self.defineConfirmPasswordField()
                                    
                    self.defineTermsAndConditionsText().alert(isPresented: self.$isShowingTerms, content: {
                        Alert(title: Text("create.account.screen.terms_title"),
                              message: Text("create.account.screen.terms_description"),
                              dismissButton: .default(Text("create.account.screen.terms_ok")
                            )
                        )
                    })
                    
                    self.defineCreateAccountButton()
                        .alert(isPresented: self.$isShowingErrorAlert, content: {
                            Alert(title: Text("create.account.screen.error_title"),
                                  message: Text("create.account.screen.error_message"),
                                  dismissButton: .cancel())
                        })
                        .alert(isPresented: self.$isFailtToMatchPassword, content: {
                            Alert(title: Text("create.account.screen.error_title"),
                                  message: Text("create.account.screen.password_fail_match"),
                                  dismissButton: .cancel())
                        })
                    
                    self.createLoginAndNeedHelpButtons()
                    
                    Spacer()
                })
            })
        }
    }
    
    fileprivate func defineScreenTitle() -> some View {
        return Text("create.account.screen.title")
            .foregroundColor(.white)
            .font(.system(size: 32, weight: .medium, design: .rounded)).padding(.bottom, 32)
    }
    
    fileprivate func defineNameField() -> BaseField {
        return BaseField(
            placeholder: Text("create.account.screen.name_placeholder").foregroundColor(.white),
            imageRightSpacing: 0,
            keyboardType: .namePhonePad,
            captalization: .words,
            text: $name,
            isSecureField: false)
    }
    
    fileprivate func defineEmailField() -> BaseField {
        return BaseField(
            placeholder: Text("welcome.screen.email_placeholder").foregroundColor(.white),
            imageRightSpacing: 0,
            keyboardType: .emailAddress,
            text: $email,
            isSecureField: false)
    }
    
    fileprivate func definePasswordField() -> BaseField {
        return BaseField(
            placeholder: Text("welcome.screen.user_password").foregroundColor(.white),
            imageRightSpacing: 0,
            text: $password,
            isSecureField: true)
    }
    
    fileprivate func defineConfirmPasswordField() -> BaseField {
        return BaseField(
            placeholder: Text("create.account.screen.confirm_password").foregroundColor(.white),
            imageRightSpacing: 0,
            text: $confirmPassword,
            isSecureField: true)
    }
    
    fileprivate func defineTermsAndConditionsText() -> some View {
        return Button(action: {
            self.isShowingTerms.toggle()
            
        }, label: {
            Text("create.account.screen.terms_part_1")
                .foregroundColor(.white)
                .font(.system(size: 12, weight: .medium, design: .rounded))
                
                +
                
                Text("create.account.screen.terms_and_conditions")
                    .foregroundColor(.white)
                    .underline(color: .white)
                    .font(.system(size: 12, weight: .medium, design: .rounded))
                
                +
                
                Text("create.account.screen.terms_part_2")
                    .foregroundColor(.white)
                    .font(.system(size: 12, weight: .medium, design: .rounded))
            
        }).padding(.horizontal, 16)
    }
    
    fileprivate func defineCreateAccountButton() -> LoginButton {
        return LoginButton(
            title: Text("welcome.screen.create_account"),
            action: {
                if self.password == self.confirmPassword {
                    
                    self.isOnLoading = true
                    
                    self.viewModel.performCreateUser(
                        name: self.name,
                        email: self.email,
                        password: self.password).subscribe(onNext: { user in
                            print("deu certo \(user)")
                            
                            self.isOnLoading = false
                            self.presentationMode.wrappedValue.dismiss()
                            
                        }, onError: { error in
                            print("fail \(error)")
                            
                            self.isOnLoading = false
                            self.isShowingErrorAlert = true
                            
                    }).disposed(by: self.viewModel.bag)
                    
                } else {
                    self.isFailtToMatchPassword = true
                }
        })
    }
    
    fileprivate func createLoginAndNeedHelpButtons() -> some View {
        return HStack {
            createLoginButton()
            
            Spacer()
            
            needHelpButton().alert(isPresented: $isShowingHelp, content: {
                Alert(title: Text("welcome.screen.need_help"),
                      message: Text("welcome.screen.contat_song"),
                      dismissButton: .default(Text("welcome.screen.okey_button_title")
                    )
                )
            })
            
        }.padding(.horizontal, 16)
    }
    
    fileprivate func createLoginButton() -> Button<HStack<Text>> {
        return Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }, label: {
            HStack {
                Text("create.account.screen.log_in_app").foregroundColor(.white)
            }
        })
    }
    
    fileprivate func needHelpButton() -> Button<HStack<Text>> {
        return Button(action: {
            self.isShowingHelp.toggle()
        }, label: {
            HStack {
                Text("welcome.screen.need_help").foregroundColor(.white)
            }
        })
    }
}

struct CreateAccountView_Previews: PreviewProvider {
    static var previews: some View {
        CreateAccountView().environment(\.locale, .init(identifier: "en"))//pt-BR
    }
}
