//
//  ViewController.swift
//  Qwerty
//
//  Created by Yafonia Hutabarat on 06/04/21.
//

import UIKit

class RiwayatSemuaViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var segmentedControl: UISegmentedControl!
    var filterContentShown: String! = "All"
    var currentTableView: Int! = 0
    let blueColor: UIColor! = #colorLiteral(red: 0, green: 0.3776819408, blue: 0.6683544517, alpha: 1)


    private var riwayatData = HistoryService().getHistory(filter: "All")
    private var kataUnikData = KataKotorService().getUniqueKataKotor(filter: "All")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Riwayat"
        print(filterContentShown)
        
        riwayatData = HistoryService().getHistory(filter: filterContentShown)
        kataUnikData = KataKotorService().getUniqueKataKotor(filter: filterContentShown)
        tableView.delegate = self
        tableView.dataSource = self
        
        let colorNotSelected = [NSAttributedString.Key.foregroundColor: UIColor.white]
        let colorSelected = [NSAttributedString.Key.foregroundColor: blueColor]
        segmentedControl.layer.borderWidth = 0.4
        segmentedControl.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        segmentedControl.setTitleTextAttributes(colorNotSelected, for: .normal)
        segmentedControl.setTitleTextAttributes(colorSelected, for: .selected)
        
        let button: UIButton = UIButton(type: UIButton.ButtonType.custom)
        button.setImage(UIImage(named: "filter"), for: .normal)
        button.addTarget(self, action:#selector(filterAction), for: UIControl.Event.touchUpInside)
        button.frame = CGRect(x: 0, y: 0, width: 10, height: 10)
        let barButton = UIBarButtonItem(customView: button)
        self.navigationItem.rightBarButtonItem = barButton
    }
    
    @IBAction func switchViewAction (_ sender: UISegmentedControl) {
        currentTableView = sender.selectedSegmentIndex
        tableView.reloadData()
    }
    
    @IBAction func filterAction (_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "filterSemuaRiwayatSegue", sender: nil)
    }
    
    @IBAction func unwindToRiwayat(_ sender: UIStoryboardSegue) {
        print("masuk")
    }
}

extension RiwayatSemuaViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        var selectedCell: UITableViewCell = tableView.cellForRow(at: indexPath) as! RiwayatSemuaTableViewCell
//        selectedCell.contentView.backgroundColor = .clear
        
        switch currentTableView {
        case 0:
            let data = riwayatData[indexPath.row]
            performSegue(withIdentifier: "showDetailSegue", sender: data)
        case 1:
            let kata = kataUnikData.0[indexPath.row].kata
            let data = HistoryService().getHistoryByKataKotor(kataKotor: kata, filter: "Month")
            performSegue(withIdentifier: "showRiwayatKataUnik", sender: data)
        default:
            break
        }

        tableView.deselectRow(at: indexPath, animated: true)        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch currentTableView {
        case 0:
            if let vc = segue.destination as? DetailKalimatViewController, let detailToSend = sender as? History {
                vc.riwayat = detailToSend
            }
        case 1:
            if let vc = segue.destination as? RiwayatKataKotorViewController, let data = sender as? [History] {
                vc.riwayatKataUnikData = data
                for i in 0...data.count - 1 {
                    let title = Converter.replaceCommaToArray(kataKotor: data[i].kataKotor!)
                    if title.count == 1 {
                        vc.navigationItem.title = Converter.addCommaFromArrayToString(kataKotor: title)
                        break
                    }
                }
            }
        default:
            break
        }
    }
}

extension RiwayatSemuaViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch currentTableView {
        case 0:
            return riwayatData.count
        case 1:
            return kataUnikData.0.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! RiwayatSemuaTableViewCell
        switch currentTableView {
        case 1:
            cell.kalimatLabel.isHidden = true
            cell.kataKotorLabel.text = kataUnikData.0[indexPath.row].kata.capitalized
            cell.timestampLabel.text = String(kataUnikData.0[indexPath.row].total)
        default:
            cell.riwayat = riwayatData[indexPath.row]
            cell.kalimatLabel.isHidden = false
        }
        return cell
    }

}
