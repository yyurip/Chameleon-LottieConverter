//
//  ColorizeHeaderView.swift
//  Chameleon
//
//  Created by Ygor Yuri De Pinho Pessoa on 01.12.24.
//

import SwiftUI
import Lottie

struct ColorizeHeaderView: View {
    @AppStorage("isDarkModeSelected") private var isDarkModeSelected: Bool = true
    
    var body: some View {
        ZStack {
            HStack {
                Button(action: {
                    isDarkModeSelected.toggle()
                }, label: {
                    Image(systemName: "circle.lefthalf.filled")
                        .renderingMode(.template)
                        .resizable()
                    .frame(width: 16, height: 16)
                    .padding(8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(.primary, lineWidth: 1)
                    )
                }).buttonStyle(PlainButtonStyle())
                Spacer()
                
            }.padding(.horizontal)
            HStack {
                Text("Chameleon")
                    .font(
                        .system(size: 50).bold()
                    )
                Image("Logo")
//                    .renderingMode(.template)
                    .resizable()
                    .frame(width: 50, height: 50)
//                    .foregroundStyle(
//                        LinearGradient(
//                            colors: [.blue, .purple, .green, .brown, .red, .pink],
//                            startPoint: .leading,
//                            endPoint: .trailing
//                        )
//                    )
            }
        }
    }
}

#Preview {
    ColorizeHeaderView()
}
