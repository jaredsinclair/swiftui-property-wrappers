import SwiftUI

final class Person: ObservableObject {
    @Published var name: String = "Bart"
}

struct BindingExampleTwo: View {
    @ObservedObject var person = Person()

    var body: some View {
        NamePicker(name: $person.name)
    }
}

struct NamePicker: View {
    @Binding var name: String

    var body: some View {
        VStack(spacing: 20) {
            Text("Tap to change:")
            CustomButton(action: {
                self.name = names.randomElement()!
            }, label: {
                Text(self.name)
            })
        }
    }
}

private let names = [
    "Homer Simpson",
    "Marge Simpson",
    "Bart Simpson",
    "Lisa Simpson",
    "Maggie Simpson",
    "Abraham Simpson",
    "Santa's Little Helper",
    "Snowball II/V",
    "Apu Nahasapeemapetilon",
    "Barney Gumble",
    "Bleeding Gums Murphy[B]",
    "Chief Clancy Wiggum",
    "Dewey Largo",
    "Eddie",
    "Edna Krabappel",
    "Itchy",
    "Janey Powell",
    "Jasper Beardsley",
    "Kent Brockman",
    "Krusty The Clown",
    "Lenny Leonard",
    "Lou",
    "Martin Prince",
    "Marvin Monroe[C]",
    "Milhouse Van Houten",
    "Moe Szyslak",
    "Mr. Burns",
    "Ned Flanders",
    "Otto Mann",
    "Patty Bouvier",
    "Ralph Wiggum",
    "Reverend Timothy Lovejoy",
    "Scratchy",
    "Selma Bouvier",
    "Seymour Skinner",
    "Sherri",
    "Sideshow Bob",
    "Terri",
    "Todd Flanders",
    "Waylon Smithers",
    "Wendell Borton",
    "Bernice Hibbert",
    "Surly Duff"
]
