import UIKit

// Factory Design Pattern

// It's an creational way of pattern it creates object for an interface(either polymorphic or not) retuns an object method (static method or not) or even regualr constructor

// Technically, there are multiple “flavors” of this pattern, including simple factory,abstract factory and others. However, each of these share a common goal: to isolate object creation logic within its own construct.

// The difference between a factory method and an abstract factory
// The factory method is (well, obviously) a method, and an abstract factory is an object. Factory methods can be overridden in a subclass. An abstract factory is an object that can have multiple factory methods.

// When to use

// Use the factory pattern whenever you want to separate out product creation logic, instead of having consumers create products directly.

// simple factory

enum Status {
    case new
    case hired
    case rejected
}
struct JobApplicant {
    let name: String
    let email: String
    let status: Status
}

struct Email {
    let subject: String
    let message: String
    let senderEmail: String
    let recipientEmail: String
}

struct EmailFactory {
    let senderEmail: String
    func makeEmail(recipient: JobApplicant) -> Email {
        let subject: String
        let messageBody: String
        
        switch recipient.status {
        case .new:
            subject = "We Received Your Application"
            messageBody =
            "Thanks for applying for a job here! " +
            "You should hear from us in 17-42 business days."
        case .hired:
            subject = "We Want to Hire You"
            messageBody =
            "Congratulations, \(recipient.name)! " +
            "We liked your code, and you smelled nice. " +
            "We want to offer you a position! Cha-ching! $$$"
        case .rejected:
            subject = "Thanks for Your Application"
            messageBody =
            "Thank you for applying, \(recipient.name)! " +
            "We have decided to move forward " +
            "with other candidates. " +
            "Please remember to wear pants next time!"
        }
        return Email(subject: subject, message: messageBody, senderEmail: senderEmail, recipientEmail: recipient.email)
    }
}

var jackson = JobApplicant(name: "Atchu",email: "atchu@example.com",status: .new)

let emailFactory =
EmailFactory(senderEmail: "vidhvaan@factory.com")
emailFactory.makeEmail(recipient: jackson)


// Abstract factory Pattern

//“Provide an interface for creating families of related or dependent objects without specifying their concrete classes.”

enum VehicleCondition {
    case new
    case used
}

final class BicycleViewController: UIViewController {
    private let condition: VehicleCondition
    init(condition: VehicleCondition) {
        self.condition = condition
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("BicycleViewController: init(coder:) has not been implemented.")
    }
}

final class ScooterViewController: UIViewController {
    private let condition: VehicleCondition
    init(condition: VehicleCondition) {
        self.condition = condition
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("ScooterViewController: init(coder:) has not been implemented.")
    }
}

protocol VehicleViewControllerFactory {
    func makeBicycleViewController() -> UIViewController
    func makeScooterViewController() -> UIViewController
}

struct NewVehicleViewControllerFactory: VehicleViewControllerFactory {
    func makeBicycleViewController() -> UIViewController {
        return BicycleViewController(condition: .new)
    }
    func makeScooterViewController() -> UIViewController {
        return ScooterViewController(condition: .new)
    }
}
struct UsedVehicleViewControllerFactory: VehicleViewControllerFactory {
    func makeBicycleViewController() -> UIViewController {
        return BicycleViewController(condition: .used)
    }
    func makeScooterViewController() -> UIViewController {
        return ScooterViewController(condition: .used)
    }
}

let factory: VehicleViewControllerFactory
    = NewVehicleViewControllerFactory()
let vc = factory.makeBicycleViewController()
