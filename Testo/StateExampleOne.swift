import SwiftUI

struct StateExampleOne: View {
    var body: some View {
        CustomButton(
            action: {
                print("You pressed me!")
            }, label: {
                Text("Press Me")
            })
    }
}

struct CustomButton<Label>: View where Label : View {
    let action: () -> Void
    let label: () -> Label

    @State private var isHighlighted = false

    var body: some View {
        let press = LongPressGesture(
            minimumDuration: .leastNormalMagnitude,
            maximumDistance: .greatestFiniteMagnitude
        ).onChanged { isPressing in
            withAnimation(.easeInOut(duration: isPressing ? 0 : 0.333)) {
                self.isHighlighted = isPressing
            }
        }
        .onEnded { _ in
            self.action()
            withAnimation(.easeInOut(duration: 0.333)) {
                self.isHighlighted = false
            }
        }

        return label()
            .foregroundColor(.blue)
            .padding()
            .background(Capsule()
                .foregroundColor(.blue)
                .opacity(isHighlighted ? 0.125 : 0))
            .gesture(press)
    }
}
