import SwiftUI

struct ObservedObjectExampleOne: View {
    @ObservedObject var veggieFetcher = VegetableFetcher()

    var body: some View {
        List(veggieFetcher.veggies) {
            Text($0.name)
        }.onAppear {
            self.veggieFetcher.fetch()
        }
    }
}

class VegetableFetcher: ObservableObject {
    @Published private(set) var veggies: [Veggie] = []

    struct Veggie: Identifiable {
        let id: String
        let name: String
        let isActuallyAFruit: Bool
    }

    func fetch() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.veggies = [
                Veggie(id: "a", name: "Carrots", isActuallyAFruit: false),
                Veggie(id: "b", name: "Peas", isActuallyAFruit: false),
                Veggie(id: "c", name: "Tomatoes", isActuallyAFruit: true),
                Veggie(id: "d", name: "Squash", isActuallyAFruit: true),
                Veggie(id: "e", name: "Asparagus", isActuallyAFruit: false)
            ]
        }
    }
}
