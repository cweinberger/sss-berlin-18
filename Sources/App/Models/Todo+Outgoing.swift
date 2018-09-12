import Vapor

extension Todo {

    struct Outgoing: Content {
        var id: Int
        var title: String?
        var completed: Bool?
        var order: Int?
        var url: String
    }
}

extension Todo {

    func makeOutgoing(with req: Request) throws -> Outgoing {
        let idString = try requireID().description
        let url = req.baseUrl + idString

        return Outgoing(
            id: try requireID(),
            title: title,
            completed: completed,
            order: order,
            url: url
        )
    }
}

extension Future where T == Todo {

    func makeOutgoing(with req: Request) throws -> Future<Todo.Outgoing> {
        return map { todo in
            return try todo.makeOutgoing(with: req)
        }
    }
}
