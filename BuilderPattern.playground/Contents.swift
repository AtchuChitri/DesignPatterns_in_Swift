import UIKit

// Builder Pattern

// Builder pattern allow to create an complex objects by providing input step by step instead of requiring all input upfront via initialiser

// Process to create Builder pattern

// Director -> Builder -> Product

// The director accepts inputs and coordinates with the builder. This is usually a view controller or a helper class that’s used by a view controller.


// 2. The product is the complex object to be created. This can be either a struct or a class, depending on desired reference semantics. It’s usually a model, but it can be any type depending on your use case.


//3. The builder accepts step-by-step inputs and handles the creation of the product.This is often a class, so it can be reused by reference.


// When to use

// if we have more inputs to create an object that's right time to use Builder pattern

//User fills a form (sign up, survey, etc.)

 // User creates custom object (question, flash card, game level, collage, etc.)
//User creates their order (pizza toppings)


// create a Product


struct Profile {
    let firstName: String
    let lastName: String
    let email: String
    let phoneNumber: String
    let address: String
}

// create builder

class ProfileBuilder {
    // why private becuase should allowed access the stored properties
    private var firstName: String = ""
    private var lastName = ""
    private var email = ""
    private var phoneNumber = ""
    private var address = ""
    
    func setFirstName(_ str: String) {
        self.firstName = str
    }
    
    func setLastName(_ str: String) {
        self.lastName = str
    }
    
    func setEmail(_ str: String) {
        self.email = str
    }
    
    func setPhoneNumber(_ str: String) {
        self.phoneNumber = str
    }
    
    func setAddress(_ str: String) {
        self.address = str
    }
    
    func build() -> Profile {
        return Profile(firstName: firstName, lastName: lastName, email: email, phoneNumber: phoneNumber, address: address)
    }
}

// Director can access the builder

class Director {
    
    let builder: ProfileBuilder
    
    init(_ builder: ProfileBuilder) {
        self.builder = builder
    }
    
    func getUserName() -> String {
        let profile = builder.build()
        return profile.firstName + profile.lastName
    }
}

let builder = ProfileBuilder()
builder.setFirstName("Atchibabu")
builder.setLastName("Chitri")
builder.setEmail("atchibabu516@gmail.com")
builder.setPhoneNumber("0000000")

let director = Director(builder)
director.getUserName()

