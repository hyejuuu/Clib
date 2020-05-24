//
//  MainView.swift
//  Clib
//
//  Created by 이혜주 on 2020/05/21.
//  Copyright © 2020 leehyeju. All rights reserved.
//

import SwiftUI
import ASCollectionView_SwiftUI


struct MainView: View {
    @State var dataExampleA = (0 ..< 21).map { $0 }
    @State var dataExampleB = (0 ..< 15).map { "ITEM \($0)" }
    
    var body: some View
    {
        ASCollectionView
        {
            ASCollectionViewSection(
                id: 0,
                data: dataExampleA,
                dataID: \.self)
            { item, _ in
                Color.blue
                    .overlay(
                        Text("\(item)")
                    )
            }
            ASCollectionViewSection(
                id: 1,
                data: dataExampleB,
                dataID: \.self)
            { item, _ in
                Color.green
                    .overlay(
                        Text("Complex layout - \(item)")
                    )
            }
            .sectionHeader
            {
                Text("Section header")
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading) //Fill width and align text to the left
                    .background(Color.yellow)
            }
            .sectionFooter
            {
                Text("This is a section footer!")
                    .padding()
            }
        }
        .layout { sectionID in
            return .grid(layoutMode: .adaptive(withMinItemSize: 50),
            itemSpacing: 5,
            lineSpacing: 5,
            itemSize: .absolute(50))
        }
    }
}

struct BestSellerView: View {
    let data: String
    
    var body: some View {
        Text(data)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
