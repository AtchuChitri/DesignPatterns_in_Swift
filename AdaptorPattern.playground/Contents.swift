import UIKit

// Adaptor Pattern

//Adapter is a structural design pattern that lets incompatible classes or structs work together.

// whene we use it

// if we don't want modifiy the code but intract with other class/struct or extend it(Like thrid party library file)

// flow

// client -> new protocol -> adaptor -> Thrid party class (adaptee or Legacy Object)

// MARK: - Legacy Object adaptee
class GoogleAuthenticator {
    func login(
        email: String,
        password: String,
        completion: @escaping (GoogleUser?, Error?) -> Void) {
            // Make networking calls that return a token string
            let token = "special-token-value"
            let user = GoogleUser(email: email,
                                  password: password,
                                  token: token)
            completion(user, nil)
        }
}
struct GoogleUser {
    var email: String
    var password: String
    var token: String
}

// new protocol

protocol AuthenticationService {
    func login(email: String,
               password: String,
               success: @escaping (User, Token) -> Void,
               failure: @escaping (Error?) -> Void)
}
struct User {
    let email: String
    let password: String
}
struct Token {
    let value: String
}


// MARK: - Adapter
// 1
class GoogleAuthenticatorAdapter: AuthenticationService {
    // 2
    private var authenticator = GoogleAuthenticator()
    // 3
    func login(email: String,
               password: String,
               success: @escaping (User, Token) -> Void,
               failure: @escaping (Error?) -> Void) {
        authenticator.login(email: email, password: password) {
            (googleUser, error) in
            
            guard let googleUser = googleUser else {
                failure(error)
                return
            }
            // 5
            let user = User(email: googleUser.email,
                            password: googleUser.password)
            let token = Token(value: googleUser.token)
            success(user, token)
        }
    }
}
