import RxFlow

enum AppStep: Step {
    case login
    case jogs
    case jogsDetail(Jog)
    case addJog
    case menu
    case info
    case close
}
