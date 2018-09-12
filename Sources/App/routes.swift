import Vapor

/// Register your application's routes here.
public func routes(_ router: Router) throws {
    // Basic "Hello, world!" example
    router.get("hello") { req in
        return "Hello, world!"
    }

    struct JSONExample: Content {
        let name: String
        let age: Int
        let birthday: Date
    }

    router.get("json") { req in
        return JSONExample(
            name: "Christian",
            age: 33,
            birthday: Date()
        )
    }

    // Example of configuring a controller
    let todoController = TodoController()

    let todos = router.grouped("todos")
    let todo = todos.grouped(Todo.parameter)

    let secureTodos = todos.grouped(SecretMiddleware.self)
    let secureTodo = todo.grouped(SecretMiddleware.self)

    todos.get(use: todoController.index)
    secureTodos.post(use: todoController.create)
    todos.delete(use: todoController.clear)

    todo.get(use: todoController.view)
    todo.patch(use: todoController.update)
    todo.delete(use: todoController.delete)
}
