import SwiftUI

struct StateExampleTwo: View {
    @State var isPresentingAlert = false

    var body: some View {
        CustomButton(action: {
            self.isPresentingAlert = true
        }, label: {
            Text("Present an Alert")
        })
        .alert(isPresented: $isPresentingAlert) {
            Alert(title: Text("Alert!"))
        }

        // Remember $isPresentingAlert is just sugar. This works, too:
        //
        //      .alert(isPresented: _isPresentingAlert.projectedValue) {
        //          Alert(title: Text("Alert!"))
        //      }
        //
    }

}
