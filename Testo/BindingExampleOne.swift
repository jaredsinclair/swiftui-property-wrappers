import SwiftUI

struct BindingExampleOne: View {
    @State var isPresentingAlert = false

    var body: some View {
        CustomButton(action: {
            self.isPresentingAlert = true
        }, label: {
            Text("Present Custom Alert")
        })
        .customAlert(isBeingPresented: $isPresentingAlert) {
            CustomAlert(title: Text("Oh no, it has happened."), dismissButtonTitle: Text("Dismiss"))
        }
    }
}

struct CustomAlert {
    let title: Text
    let dismissButtonTitle: Text
}

extension View {
    func customAlert(isBeingPresented: Binding<Bool>, alert: () -> CustomAlert) -> some View {
        CustomAlertView(
            isBeingPresented: Binding<Bool>(
                get: { isBeingPresented.wrappedValue },
                set: { newValue in
                    withAnimation(.easeInOut) {
                        isBeingPresented.wrappedValue = newValue
                    }
                }),
            model: alert(),
            presentingContent: AnyView(self)
        )
    }
}

private struct CustomAlertView: View {
    
    @Binding var isBeingPresented: Bool
    let model: CustomAlert
    let presentingContent: AnyView

    var body: some View {
        ZStack {
            presentingContent
            GeometryReader { proxy in
                ZStack {
                    Rectangle()
                        .foregroundColor(.black)
                        .opacity(0.25)
                        .aspectRatio(nil, contentMode: .fill)
                        .edgesIgnoringSafeArea(.all)
                        .onTapGesture { self.isBeingPresented = false }
                    VStack(spacing: 10) {
                        self.model.title
                            .font(.headline)
                            .fontWeight(.black)
                        CustomButton(
                            action: {
                                self.isBeingPresented = false
                            }, label: {
                                self.model.dismissButtonTitle
                                    .foregroundColor(.blue)
                                    .fontWeight(.bold)
                            }).aspectRatio(contentMode: .fill)
                       }.padding(.top, 40)
                        .padding(.bottom, 20)
                        .frame(width: proxy.size.width - 40)
                        .background(Capsule().foregroundColor(.white))
                }
            }.opacity(isBeingPresented ? 1 : 0)
        }
    }
}
