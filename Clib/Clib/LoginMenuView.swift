//
//  LoginMenuView.swift
//  Clib
//
//  Created by 이혜주 on 2020/05/22.
//  Copyright © 2020 leehyeju. All rights reserved.
//

import SwiftUI

struct LoginMenuView: View {
    var body: some View {
        NavigationView {
            VStack(alignment: .center, spacing: 20) {
                Spacer()
                
                NavigationLink(destination: SignInView()) {
                    Text("Apple로 로그인")
                        .padding()
                        .frame(minWidth: 0, maxWidth: .infinity)
                }
                .foregroundColor(.white)
                .background(Color.black)
                .cornerRadius(10)
                .padding([.leading, .trailing], 80)
                
                NavigationLink(destination: SignInView()) {
                    Text("Google로 로그인")
                        .padding()
                        .frame(minWidth: 0, maxWidth: .infinity)
                }
                .background(Color.black)
                .cornerRadius(10)
                .padding([.leading, .trailing], 80)
            
                NavigationLink(destination: SignInView()) {
                    Text("직접 입력")
                        .padding()
                        .frame(minWidth: 0, maxWidth: .infinity)
                }
                .background(Color.black)
                .cornerRadius(10)
                .padding([.leading, .trailing], 80)
                
                Spacer().frame(height: 30)
            }
        }
    }
    func touchUpActionButton() {
        SignInView()
    }
}

struct LoginMenuView_Previews: PreviewProvider {
    static var previews: some View {
        LoginMenuView()
    }
}
