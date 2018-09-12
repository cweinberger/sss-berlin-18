import Vapor

final class SecretMiddleware {

    let secret: String

    init(secret: String) {
        self.secret = secret
    }
}

extension SecretMiddleware: Service {}

extension SecretMiddleware: Middleware {

    func respond(
        to req: Request,
        chainingTo next: Responder
    ) throws -> Future<Response> {

        guard let auth = req.http.headers.firstValue(name: HTTPHeaderName.authorization) else {
            throw Abort(.unauthorized, reason: "Please include the Authorization header.")
        }

        guard auth == "Bearer secret" else {
            throw Abort(.unauthorized, reason: "Incorrect secret.")
        }

        return try next.respond(to: req)
    }
}
