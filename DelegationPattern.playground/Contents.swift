import UIKit

// The core purpose of the delegate pattern is to allow an object to communicate back to its owner in a decoupled way. By not requiring an object to know the concrete type of its owner, we can write code that is much easier to reuse and maintain.

// commonly we find these delegation way in UITableViewDelegate , UITableViewDataSource , CollectionViewDelegate so basically UIKit

// When we should use this pattren

// if we want to comminicate b/w two objects and pass the information we need this pattern

// is there any alternative for this patten
// 1) Yes We can Achive by NotificationCenter as well but it's like pass the information to all it's not like one to one
// 2) Subclassing can replace Delegate but it has come with  tightly-coupled also even we need to inherit the entire class even if not needed

// Advantage of delegation

// Delegation is more lightweight than subclassing, because you don’t have to inherit a complete class or struct
//Delegation is useful for 1-on-1 relationships, whereas the Observer pattern is more suitable for one-to-many and many-to-many relationships.
// Delegation is flexible, because it doesn’t require the delegating class to know anything at all about a delegate – only that it conforms to a protocol



// How many ways we can do this Delegate pattern

// 1) Protocol Delegation 2) Clouser

enum ViewAction {
    case buttonTapped
    case startLoader
    case stopLoader
}
protocol ViewActionDelegate: AnyObject {
    func handle(_ action: ViewAction)
}

struct Owner {
   weak var delegate: ViewActionDelegate?
    func handle(_ action: ViewAction) {
        delegate?.handle(action)
    }
}

class MainView: ViewActionDelegate {
    
    init() {
    }
    
    func handle(_ action: ViewAction) {
        print("Select Action :", action)
    }
}

let mainV = MainView()

var onwer = Owner()
onwer.delegate = mainV
onwer.handle(.buttonTapped)


// clouser Way of delegation

struct ViewEvents {
    var handle: ((ViewAction?) -> Void)?
    
    func eventOccur(event: ViewAction) {
        handle?(event)
        }
}

class ViewController {
    var events: ViewEvents
    
    init() {
        events = ViewEvents()
        events.eventOccur(event: .buttonTapped)
        events.handle = { [weak self] event in
            print(event)
        }
    }
}
