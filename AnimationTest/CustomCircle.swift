//
//  CustomCircle.swift
//  AnimationTest
//
//  Created by 中山龍 on 2022/05/13.
//

import SwiftUI

struct CustomCircle: View {
    @Binding var circleAngle: Double
    var body: some View {
        Text("\(circleAngle)")

        AnimationReader(circleAngle) { value in
                    // count ではなく value の方を使って表示する
            ZStack {
                Image(systemName: "checkmark")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .foregroundColor(.green)
                    .opacity(value <= 330 ? 0 : 1)

                Path { path in
                    path.addArc(center: CGPoint(x: 50, y: 50), radius: 50, startAngle: Angle(degrees: 0), endAngle: Angle(degrees: value), clockwise: false)

                }
                .stroke(Color.green, lineWidth: 10)
                .frame(width: 100, height: 100)
                .opacity(value/360)
            }
        }
    }
}

struct CustomCircle_Previews: PreviewProvider {
    static var previews: some View {
        CustomCircle(circleAngle: .constant(360))
            .previewLayout(.sizeThatFits)
    }
}


fileprivate struct AnimationReaderModifier<Body: View>: AnimatableModifier {
    let content: (CGFloat) -> Body
    var animatableData: CGFloat

    init(value: CGFloat, @ViewBuilder content: @escaping (CGFloat) -> Body) {
        self.animatableData = value
        self.content = content
    }

    func body(content: Content) -> Body {
        self.content(animatableData)
    }
}

struct AnimationReader<Content: View>: View {

    let value: CGFloat
    let content: (_ animatingValue: CGFloat) -> Content

    init(_ observedValue: Int, @ViewBuilder content: @escaping (_ animatingValue: Int) -> Content) {
        self.value = CGFloat(observedValue)
        self.content = { value in content(Int(value)) }
    }

    init(_ observedValue: CGFloat, @ViewBuilder content: @escaping (_ animatingValue: CGFloat) -> Content) {
        self.value = observedValue
        self.content = content
    }

    var body: some View {
        EmptyView()
            .modifier(AnimationReaderModifier(value: value, content: content))
    }
}
