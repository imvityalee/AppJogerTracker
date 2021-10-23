
import Foundation

public struct Constants {
    static let userTokenKey = "userTokenKey"
    static let userTokenTypeKey = "userTokenTypeKey"
}

public struct ImageConstants {
    static var imageLogo: String = "logo"
    static var menuImage: String = "menu"
    static var filterImage: String = "filter"
    static var imageGreenLogo: String = "logoGreen"
    static var add: String = "add"
    static var jogIcon: String = "jogIcon"
}

public struct LabelConstants {
    static var jogs: String  = "Jogs"
    static var save: String = "Save"
    static var info: String = "Info"
    static var uuid: String = "UUID"
    static var login: String = "Login"
    static var jogCell: String = "JogCell"
    static var distance: String = "Distance"
    static var time: String = "Time"
    static var date: String = "Date"
    static var textViewData: String = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."
    static var tryAgain: String = "Try again please"
    static var alerErrorTitle: String = "Error occured"
    static var alertAuthError: String = "Invalid user UUID" 
}

public struct URLConstants {
    static let baseUrlString = "https://jogtracker.herokuapp.com/api/v1"
    
    static var baseURL: URL {
        if let url = URL(string: baseUrlString) {
            return url
        } else  {
            fatalError("The base url was not defined")
        }
    }
}
