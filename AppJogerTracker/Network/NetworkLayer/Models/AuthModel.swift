import Foundation
import ObjectMapper

struct LoginResponse: Decodable {
    let response: AuthModel
}
struct AuthModel: Decodable {
    
    let accessToken: String
      let tokenType: String
  
      enum CodingKeys: String, CodingKey {
          case accessToken = "access_token"
          case tokenType = "token_type"
      }
  
      init(from decoder: Decoder) throws {
          let container = try decoder.container(keyedBy: CodingKeys.self)
          accessToken = try container.decode(String.self, forKey: .accessToken)
          tokenType = try container.decode(String.self, forKey: .tokenType)
      }
}



//    var accessToken: String?
//    var tokenType: String?
//
//    init () { }
//    init?(map: Map) { self.init()   }
//
//    mutating func mapping(map: Map) {
//        accessToken <- map["access_token"]
//        tokenType <- map["token_type"]
//    }
