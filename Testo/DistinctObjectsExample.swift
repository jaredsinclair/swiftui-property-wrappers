import SwiftUI

struct DistinctObjectsExample: View {

    @DistinctEnvironmentObject(\.posts) var postsService: Microservice
    @DistinctEnvironmentObject(\.users) var usersService: Microservice
    @DistinctEnvironmentObject(\.channels) var channelsService: Microservice

    var body: some View {
        Form {
            Section(header: Text("Posts")) {
                List(postsService.content, id: \.self) {
                    Text($0)
                }
            }

            Section(header: Text("Users")) {
                List(usersService.content, id: \.self) {
                    Text($0)
                }
            }

            Section(header: Text("Channels")) {
                List(channelsService.content, id: \.self) {
                    Text($0)
                }
            }
        }.onAppear(perform: fetchContent)
    }

    func fetchContent() {
        postsService.fetchContent()
        usersService.fetchContent()
        channelsService.fetchContent()
    }
}

// MARK: - Property Wrapper To Make This All Work

@propertyWrapper
struct DistinctEnvironmentObject<Wrapped>: DynamicProperty where Wrapped : ObservableObject {
    var wrappedValue: Wrapped {
        _wrapped
    }

    @ObservedObject private var _wrapped: Wrapped

    init(_ keypath: KeyPath<EnvironmentValues, Wrapped>) {
        _wrapped = Environment<Wrapped>(keypath).wrappedValue
    }
}

// MARK: - Dependencies

class Microservice: ObservableObject {
    @Published private(set) var content: [String] = []

    func fetchContent() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.content = self.fakeContentForDemo
        }
    }

    private let fakeContentForDemo: [String]

    init(fakeContentForDemo: [String]) {
        self.fakeContentForDemo = fakeContentForDemo
    }
}

extension Microservice {
    static let posts = Microservice(
        fakeContentForDemo:  ["What about Mesa Verde?", "S'all good, man."]
    )
}

extension Microservice {
    static let users = Microservice(
        fakeContentForDemo: ["Jimmy", "Kim", "Mike"]
    )
}

extension Microservice {
    static let channels = Microservice(
        fakeContentForDemo: ["#watercooler", "#gifs", "#drugtrafficking"]
    )
}

// MARK: - Environment Boilerplate

struct PostsServiceKey: EnvironmentKey {
    static var defaultValue: Microservice {
        return Microservice.posts
    }
}

struct UsersServiceKey: EnvironmentKey {
    static var defaultValue: Microservice {
        return Microservice.users
    }
}

struct ChannelsServiceKey: EnvironmentKey {
    static var defaultValue: Microservice {
        return Microservice.channels
    }
}

extension EnvironmentValues {
    var posts: Microservice {
        get { return self[PostsServiceKey.self]  }
        set { self[PostsServiceKey.self] = newValue }
    }

    var users: Microservice {
        get { return self[UsersServiceKey.self]  }
        set { self[UsersServiceKey.self] = newValue }
    }

    var channels: Microservice {
        get { return self[ChannelsServiceKey.self]  }
        set { self[ChannelsServiceKey.self] = newValue }
    }
}
