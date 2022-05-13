//
//  ContentView.swift
//  AnimationTest
//
//  Created by 中山龍 on 2022/05/13.
//

import SwiftUI

struct ContentView: View {
    @State var animationFlag: Bool = false
    @State var circleAngle: Double = 0
    var body: some View {
        VStack {
            Text("Hello, world!")
                .padding()
            CustomCircle(circleAngle: self.$circleAngle)

            Button(action: {
                withAnimation(.linear(duration: 0.3)) {
                    self.animationFlag.toggle()
                    if(animationFlag == true) {
                        circleAngle += 360
                    } else {
                        circleAngle -= 360
                    }
                }
            }, label: {
                Text("animation")
            })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
