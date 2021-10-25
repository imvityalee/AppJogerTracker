import Foundation

struct GetJogsResponse: Decodable {
    let response: Jogs
}

struct Jogs: Decodable {
    let jogs: [Jog]
}

struct AddJogResponse: Decodable {
    let response: JogResponse
}

struct JogResponse: Decodable {
    let id: Int
}

struct Jog: Decodable {
    let id: Int?
    let userId: String?
    var distance: Float
    var time: Float
    var date: Date
    var speed: Float {
        return distance / (time / 60)
    }

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case userId = "user_id"
        case distance = "distance"
        case time = "time"
        case date = "date"
    }

    init() {self.init(id: nil, userId: nil, distance: 0, time: 0, date: Date()) }

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

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        userId = try container.decode(String.self, forKey: .userId)
        distance = try container.decode(Float.self, forKey: .distance)
        time = try container.decode(Float.self, forKey: .time)
        date = try container.decode(Date.self, forKey: .date)
    }
}
