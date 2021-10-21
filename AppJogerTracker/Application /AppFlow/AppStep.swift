import RxFlow

enum AppStep: Step {
    case login
    case jogs
    case jogsDetail(Jog)
    case menu
    case info
    case close
}
