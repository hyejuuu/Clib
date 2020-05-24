//
//  ClibCollectionView.swift
//  Clib
//
//  Created by 이혜주 on 2020/05/22.
//  Copyright © 2020 leehyeju. All rights reserved.
//

import SwiftUI

struct CollectionView<Content: View>: View {
//    let header: View
//    let footer: View
    let cell: Content
    let raw: Int
    let column: Int
    let numberOfItem: Int
    
    var body: some View {
        List {
            ForEach(0..<raw-1, id: \.self) { _ in
                HStack {
                    ForEach(0..<self.column, id: \.self) { _ in
                        self.cell
                    }
                }
            }
            
            HStack {
                ForEach(0...(numberOfItem - (raw * (column - 1))), id: \.self) { _ in
                    self.cell
                }
            }
        }
    }
}

protocol CellProtocol {
    var width: CGFloat { get }
    var height: CGFloat { get }
}

struct Cell: View, CellProtocol {
    let width: CGFloat
    let height: CGFloat
    
    var body: some View {
        Rectangle().background(Color.black).frame(width: width, height: height)
    }
}
