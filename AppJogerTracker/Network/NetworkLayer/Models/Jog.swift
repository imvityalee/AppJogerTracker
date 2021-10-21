import ObjectMapper
import Foundation

typealias EditJogResponse = CreateJogResponse

struct GetJogsResponse: Decodable {
    let response: Jogs
}

struct Jogs: Decodable {
    let jogs: [Jog]
}

struct CreateJogResponse: Decodable {
    let response: JogResponse
}

struct JogResponse: Decodable {
    let id: Int
}


struct Jog: Mappable, Decodable {
    var id: Int?
    var userId: String?
    var distance: Float = .init()
    var time: Float = .init()
    var date: Date = .init()
    var speed: Float {
        return distance / (time / 60)
    }
    
    init() {}
    
     init(id: Int?,
                  userId: String?,
                  distance: Float,
                  time: Float,
                  date: Date) {
        self.id = id
        self.userId = userId
        self.distance = distance
        self.time = time
        self.date = date
    }

    init?(map: Map) {  self.init() }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        userId <- map["user_id"]
        distance <- map["distance"]
        time <- map["time"]
        date <- map["date"]
    }
    
    
}
