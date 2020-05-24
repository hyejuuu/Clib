//
//  SignInView.swift
//  Clib
//
//  Created by 이혜주 on 2020/05/19.
//  Copyright © 2020 leehyeju. All rights reserved.
//

import SwiftUI

struct SignInView: View {
    @State var id: String = ""
    @State var password: String = ""
    
    var body: some View {
        VStack(alignment: .center, spacing: 50) {
            VStack(alignment: .center, spacing: 30) {
                VStack {
                    TextField("아이디를 입력해주세요", text: $id)
                    Divider()
                }
                
                VStack {
                    TextField("비밀번호를 입력해주세요", text: $password)
                    Divider()
                }
            }
            
            HStack(alignment: .center, spacing: 30) {
                NavigationLink(destination: TabBarView()) {
                    Text("로그인")
                }
                NavigationLink(destination: TabBarView()) {
                    Text("회원가입")
                }
            }
        }
        .navigationBarTitle("로그인", displayMode: .inline)
        .padding([.leading, .trailing], 50)
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
