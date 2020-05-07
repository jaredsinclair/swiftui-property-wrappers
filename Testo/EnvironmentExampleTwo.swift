import SwiftUI

struct EnvironmentExampleTwo: View {
    @Environment(\.positiveTheme) var positiveTheme: Theme
    @Environment(\.negativeTheme) var negativeTheme: Theme

    var body: some View {
        VStack(spacing: 40) {
            Text("Positive")
                .fontWeight(.black)
                .font(.largeTitle)
                .foregroundColor(positiveTheme.foregroundColor)
                .padding(32)
                .background(
                    Capsule().foregroundColor(positiveTheme.backgroundColor))
            Text("Negative")
                .fontWeight(.black)
                .font(.largeTitle)
                .foregroundColor(negativeTheme.foregroundColor)
                .padding(32)
                .background(
                    Capsule().foregroundColor(negativeTheme.backgroundColor))
        }
    }
}

// MARK: - Dependencies

struct PositiveTheme: Theme {
    var foregroundColor: Color { .white }
    var backgroundColor: Color { .green }
}

struct NegativeTheme: Theme {
    var foregroundColor: Color { .white }
    var backgroundColor: Color { .red }
}

// MARK: - Environment Boilerplate

struct PositiveThemeKey: EnvironmentKey {
    static var defaultValue: Theme {
        return PositiveTheme()
    }
}

struct NegativeThemeKey: EnvironmentKey {
    static var defaultValue: Theme {
        return NegativeTheme()
    }
}

extension EnvironmentValues {
    var positiveTheme: Theme {
        get { return self[PositiveThemeKey.self]  }
        set { self[PositiveThemeKey.self] = newValue }
    }

    var negativeTheme: Theme {
        get { return self[NegativeThemeKey.self]  }
        set { self[NegativeThemeKey.self] = newValue }
    }
}
