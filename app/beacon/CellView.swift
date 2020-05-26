//
//  CellView.swift
//  beacon
//
//  Created by Dylan Todd on 5/25/20.
//  Copyright © 2020 Dotlao. All rights reserved.
//

import SwiftUI

struct CellView: View {
    var item: TestData
    var body: some View {
        HStack{
            Text(item.name)
            Spacer()
            Text("details")
                .font(.caption)
                .foregroundColor(Color.gray)
        }
    }
}
