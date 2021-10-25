import Foundation

struct JogsDetailPresentableModel {
    var distance: Float
    var time: Float
    var date: Date
    
    init(distance: Float = 0,
         time: Float = 0,
         date: Date = Date.init() ) {
        self.distance = distance
        self.time = time
        self.date = date
    }
}
