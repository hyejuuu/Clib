//
//  TabBarView.swift
//  Clib
//
//  Created by 이혜주 on 2020/05/21.
//  Copyright © 2020 leehyeju. All rights reserved.
//

import SwiftUI

struct TabBarView: View {
    var body: some View {
        TabView {
            MainView()
              .tabItem {
                 Image(systemName: "phone.fill")
                 Text("Home")
               }
            
            MyLibraryView()
              .tabItem {
                 Image(systemName: "tv.fill")
                 Text("My Library")
               }
            
            MyQuoteView()
                .tabItem {
                    Image(systemName: "tv.fill")
                    Text("My Quote")
                }
            
            MyPageView()
                .tabItem {
                    Image(systemName: "tv.fill")
                    Text("My Page")
            }
        }
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}
