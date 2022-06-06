//
//  NavBarView.swift
//  Shop
//
//  Created by Настя on 15.04.2022.
//

import SwiftUI

struct NavBarView <Content: View>: View {
    
    let content: Content
    
    init(@ViewBuilder builder: () -> Content) {
        self.content = builder()
    }
    
    var body: some View {
        content
            .padding(.bottom, 12)
            .frame(maxWidth: .infinity)
            .frame(height: 61, alignment: .bottom)
            .background(Color("bar").edgesIgnoringSafeArea(.top))
    }
}
