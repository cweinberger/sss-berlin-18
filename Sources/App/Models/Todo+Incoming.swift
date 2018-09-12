import Vapor

extension Todo {

    struct Incoming: Content {
        var title: String?
        var completed: Bool?
        var order: Int?

        func makeTodo() -> Todo {

            return Todo(
                id: nil,
                title: title ?? "Untitled",
                completed: completed ?? false,
                order: order
            )
        }
    }
}
