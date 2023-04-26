import UIKit

// Chain Of Responsibility Pattern

//The chain-of-responsibility pattern is a behavioral design pattern that allows an event to be processed by one of many handlers.


// when to use

//Use this pattern whenever you have a group of related objects that handle similar events but vary based on event type, attributes or anything else related to the event.

protocol Video {
    var next: Video? { get set }
    func VideoType(_ category: String)
}

struct Mp4Video: Video {
    var next: Video?
    
    func VideoType(_ category: String) {
        if category.components(separatedBy: ".")[1] == "mp4" {
            print("Video Type Mp4")
        }
        guard let next = next else {
            return print("End of Loop")
        }
        next.VideoType(category)
    }
}

struct MOVVideo: Video {
    var next: Video?
    
    func VideoType(_ category: String) {
        if category.components(separatedBy: ".")[1] == "mov" {
            print("Video Type MOV")
        }
        guard let next = next else {
            return print("End of Loop")
        }
        next.VideoType(category)
    }
}


var mp4 = Mp4Video()
mp4.next = MOVVideo()
print(mp4.VideoType("SwiftUI.mov"))//Video Type MOV

