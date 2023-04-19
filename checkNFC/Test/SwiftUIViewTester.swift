//
//  SwiftUIViewTester.swift
//  checkNFC
//
//  Created by Heonjin Ha on 2023/04/12.
//

import SwiftUI

struct SwiftUIViewTester: View {
    var body: some View {
        ZStack(alignment: .center) {
            ZStack(alignment: .center) {
                VStack {
                    Text("Hi")
                }
            }
        }
    }
}

struct SwiftUIViewTester_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIViewTester()
    }
}
