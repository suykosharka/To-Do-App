//
//  HeaderView.swift
//  MVC+FireBase TestApp
//
//  Created by Илья Паршин on 09.02.2025.
//

import SwiftUI

struct HeaderView: View {
    
    let title: String
    let subtitle: String
    let background: Color
    
    var body: some View {
        ZStack {
            Circle()
                .fill(background)
                .frame(width: 1000, height: 1000)
                .offset(y: -500)
                
            VStack {
                Text(title)
                    .font(.system(size: 50))
                    .foregroundColor(Color.white)
                    .bold()
                Text(subtitle)
                    .font(.system(size: 30))
                    .foregroundColor(Color.white)
            }
            .padding(.bottom, 125)
        }
        .frame(height: 350)
        .ignoresSafeArea(edges: .top)
        
    }
}

#Preview {
    HeaderView(title: "Title", subtitle: "Subtitle", background: .blue)
}
