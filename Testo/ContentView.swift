import SwiftUI

struct ContentView: View {
    @State var isPresentingAlert = false

    var body: some View {
        List(Example.allCases) { example in
            NavigationLink(
                destination: example.view.navigationBarTitle(example.title),
                label: { Text(example.title) }
            )
        }.navigationBarTitle(Text("Property Wrappers"), displayMode: .large)
    }

}

enum Example: String, CaseIterable, Identifiable {
    case stateOne, stateTwo
    case bindingOne, bindingTwo
    case observedObjectOne, observedObjectTwo
    case environmentObject
    case environmentOne, environmentTwo
    case distinctObjects

    var id: String { rawValue }

    var title: String {
        switch self {
        case .stateOne: return "State 1"
        case .stateTwo: return "State 2"
        case .bindingOne: return "Binding 1"
        case .bindingTwo: return "Binding 2"
        case .observedObjectOne: return "ObservedObject 1"
        case .observedObjectTwo: return "ObservedObject 2"
        case .environmentObject: return "EnvironmentObject"
        case .environmentOne: return "Environment 1"
        case .environmentTwo: return "Environment 2"
        case .distinctObjects: return "Distinct Objects"
        }
    }

    var view: AnyView {
        switch self {

        case .stateOne:
            return StateExampleOne().erased

        case .stateTwo:
            return StateExampleTwo().erased

        case .bindingOne:
            return BindingExampleOne().erased

        case .bindingTwo:
            return BindingExampleTwo().erased

        case .observedObjectOne:
            return ObservedObjectExampleOne().erased

        case .observedObjectTwo:
            return ObservedObjectExampleTwo(
                dessertFetcher: DessertFetcher(
                    preferences: DessertFetcher.UserPreferences(
                        toleratesMint: false
                    )
                )
            ).erased

        case .environmentObject:
            return EnvironmentObjectExample()
                .environmentObject(VegetableFetcher())
                .erased

        case .environmentOne:
            return EnvironmentExampleOne()
                .environment(\.theme, PinkTheme())
                .erased

        case .environmentTwo:
            return EnvironmentExampleTwo()
                .environment(\.positiveTheme, PositiveTheme())
                .environment(\.negativeTheme, NegativeTheme())
                .erased

        case .distinctObjects:
            return DistinctObjectsExample()
                .environment(\.posts, Microservice.posts)
                .environment(\.users, Microservice.users)
                .environment(\.channels, Microservice.channels)
                .erased
        }
    }
}

extension View {
    var erased: AnyView {
        return AnyView(self)
    }
}
