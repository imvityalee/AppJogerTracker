import Foundation
import RxDataSources
import RxSwift
//Demo

struct JogsSactionModel {
    var header: String
    var items: [Jog]
    
}

extension JogsSactionModel: SectionModelType {
    typealias Item = Jog
    
    init(original: JogsSactionModel, items: [Jog]) {
        self = original
        self.items = items
    }
    
}

struct JogsTableViewDataSource {
    
    typealias JogsDataSource = RxTableViewSectionedReloadDataSource<JogsSactionModel>
    
    static func dataSource(_ tableView: UITableView) -> JogsDataSource {
        return JogsDataSource.init { dataSource, tableView, indexPath, item in
            tableView.register(JogCell.self, forCellReuseIdentifier: LabelConstants.jogCell)
            
            let cell = tableView.dequeueReusableCell(withIdentifier: LabelConstants.jogCell, for: indexPath) as! JogCell
            cell.confiugre(wtih: item)
            
            return cell
        } titleForHeaderInSection: { dataSource, index in
            return dataSource.sectionModels[index].header
        }
    }
    
}

extension JogsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
