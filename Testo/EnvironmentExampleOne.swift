import SwiftUI

struct EnvironmentExampleOne: View {
    @Environment(\.theme) var theme: Theme

    var body: some View {
        Text("CLIPPER SHIPS\n\nMe and my dad make models of clipper ships. I like clipper ships because they are fast. Clipper ships sail on the ocean. Clipper ships never sail on rivers or lakes. Clipper ships have lots of sails and are made of wood.\n\n~ Matt Montini")
            .foregroundColor(theme.foregroundColor)
            .padding(32)
            .background(theme.backgroundColor)
            .cornerRadius(32)
            .padding(32)
    }
}

// MARK: - Dependencies

protocol Theme {
    var foregroundColor: Color { get }
    var backgroundColor: Color { get }
}

struct PinkTheme: Theme {
    var foregroundColor: Color { .white }
    var backgroundColor: Color { .pink }
}

struct GreenTheme: Theme {
    var foregroundColor: Color { .yellow }
    var backgroundColor: Color { .green }
}

struct BlueTheme: Theme {
    var foregroundColor: Color { .white }
    var backgroundColor: Color { .blue }
}

// MARK: - Environment Boilerplate

struct ThemeKey: EnvironmentKey {
    static var defaultValue: Theme {
        return BlueTheme()
    }
}

extension EnvironmentValues {
    var theme: Theme {
        get { return self[ThemeKey.self]  }
        set { self[ThemeKey.self] = newValue }
    }
}
