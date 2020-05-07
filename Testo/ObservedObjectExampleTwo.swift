import SwiftUI

struct ObservedObjectExampleTwo: View {
    @ObservedObject var dessertFetcher: DessertFetcher

    var body: some View {
        List(dessertFetcher.desserts) {
            Text($0.name)
        }.onAppear {
            self.dessertFetcher.fetch()
        }
    }
}

extension UIViewController {

    func observedObjectExampleTwo() -> UIViewController {
        let fetcher = DessertFetcher(preferences: .init(toleratesMint: false))
        let view = ObservedObjectExampleTwo(dessertFetcher: fetcher)
        let host = UIHostingController(rootView: view)
        return host
    }

}

class DessertFetcher: ObservableObject {
    @Published private(set) var desserts: [Dessert] = []

    let preferences: UserPreferences

    init(preferences: UserPreferences) {
        self.preferences = preferences
    }

    struct UserPreferences {
        let toleratesMint: Bool
    }

    struct Dessert: Identifiable {
        let id: String
        let name: String
        let isMinty: Bool
    }

    func fetch() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.desserts = [
                Dessert(id: "a", name: "Strawberry Ice Cream", isMinty: false),
                Dessert(id: "c", name: "Creme Bruleé", isMinty: false),
                Dessert(id: "d", name: "Tiramisu", isMinty: false),
            ]
        }
    }
}
