import UIKit

// Strategy pattern

// Encapsulates algorithms in classes, making them reusable and interchangeable at runtime.

// When to use

//Use the strategy pattern when you have two or more different behaviors that are interchangeable.

// example movie rating from different firms like IMDB Ritten Tomatoes so movie rating can be dynamicaly interchangble from these 2 firms

protocol MovieRatingStrategy {
    var ratingService: String { get }
    
    func fetchRating(for movieTitle: String, success:(_ rating: String, _ review: String) -> ())
}

class RottenTomotoes: MovieRatingStrategy {
    var ratingService = "Rotten Tomatoes"
    
    func fetchRating(for movieTitle: String, success: (String, String) -> ()) {
        let rating = "95%"
        success(rating, "It rocked")
    }
}

class IMDB: MovieRatingStrategy {
    var ratingService = "IMDB"
    
    func fetchRating(for movieTitle: String, success: (String, String) -> ()) {
        success("3/10", "It was teriable! the audience was thorwing rotten tomotoes")
    }
}

class MovieRatingView {
    let strategy: MovieRatingStrategy

    init (_ strategy: MovieRatingStrategy) {
        self.strategy = strategy
    }
    
    func getMovieRating(_ title: String) {
        self.strategy.fetchRating(for: title) { rating, review in
            print(title + "=======Movie Rating======")
            print(rating)
            print(review)
        }
    }
}

// Rotten
let movie = MovieRatingView(RottenTomotoes())
movie.getMovieRating("Pathan")

// IMDB
let movieI = MovieRatingView(IMDB())
movieI.getMovieRating("Pathan")

// So with out expose concreate type we can use MovieRatingStrategy to fullfill the requirment and switch interchangblly
// if observe we have to define what that concreate type while get specified result 
