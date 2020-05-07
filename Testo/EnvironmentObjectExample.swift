import SwiftUI

struct EnvironmentObjectExample: View {
    @EnvironmentObject var veggieFetcher: VegetableFetcher

    var body: some View {
        List(veggieFetcher.veggies) {
            Text($0.name)
        }.onAppear {
            self.veggieFetcher.fetch()
        }
    }
}

struct SomeParentView: View {
    var body: some View {
        EnvironmentObjectExample()
    }
}

struct SomeGrandparentView: View {
    var body: some View {
        SomeParentView()
    }
}
