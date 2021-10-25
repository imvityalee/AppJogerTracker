import Foundation

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
