import UIKit

// Command Pattern

//The command pattern is a behavioral pattern that encapsulates information to perform an action into a command object. It involves three types:
//The invoker stores and executes commands.
// The command encapsulates the action as an object.
//The receiver is the object that’s acted upon by the command.

// Command pattern act like nsinvocation in Objective c

// When to use

// Mainly use for any Undo/Redo functionality in a program and store all of the actions in a history list and possibly to revert to earlier states by executing the stored actions in reverse order

//Use this pattern whenever you want to create actions that can be executed on receivers at a later point in time.

// The command pattern is also suitable for executing global command, such as sending user analytics

// Receiver
class Calculator {
    func add(x: Int, y: Int) -> Int {
        return x+y
    }
    func subtraction(x: Int, y: Int) -> Int {
        return x - y
    }
}

// Command

protocol Command {
  func execute() -> Int
}

// concreate Command class

class AddCommand: Command {
    let receiver: Calculator
    let x: Int
    let y: Int
    init(receiver: Calculator, x: Int, y: Int) {
        self.receiver = receiver
        self.x = x
        self.y = y
    }
    func execute() -> Int {
        return receiver.add(x: x, y: y)
    }
}
// concreate Command  class 2

class SubtractionCommand: Command {
    let receiver: Calculator
    let x: Int
    let y: Int
    init(receiver: Calculator, x: Int, y: Int) {
        self.receiver = receiver
        self.x = x
        self.y = y
    }
    func execute() -> Int {
        return receiver.subtraction(x: x, y: y)
    }
}

// Invoker class

class CalculatorInvoker {
    var history:[Command] = []
    
    func invoke(command: Command) {
        history.append(command)
        print(command.execute())
    }
    
    func undo() {
        if !history.isEmpty {
            history.removeLast()
        }
    }
}

let calculator = Calculator()
let addCommand = AddCommand(receiver: calculator, x: 5, y: 7)
let subtractCommand = SubtractionCommand(receiver: calculator, x: 5, y: 3)

let invoker = CalculatorInvoker()

invoker.invoke(command: addCommand)
invoker.invoke(command: subtractCommand)
invoker.undo()

