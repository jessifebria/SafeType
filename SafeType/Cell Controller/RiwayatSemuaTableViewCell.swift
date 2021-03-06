//
//  RiwayatSemuaTableViewCell.swift
//  Qwerty
//
//  Created by Yafonia Hutabarat on 06/04/21.
//

import UIKit

class RiwayatSemuaTableViewCell: UITableViewCell {
    
    @IBOutlet var kataKotorLabel: UILabel!
    @IBOutlet var kalimatLabel: UILabel!
    @IBOutlet var timestampLabel: UILabel!
    @IBOutlet var view: UIView!
    @IBOutlet var horizontalStackView: UIStackView!
    
    var riwayat: History? {
        didSet {
            guard let riwayatItem = riwayat else {return}
            if let kataKotor = riwayatItem.kataKotor {
                let arrayKataKotor = Converter.replaceCommaToArray(kataKotor: kataKotor)
                let stringKataKotor = Converter.addCommaFromArrayToString(kataKotor: arrayKataKotor)
                kataKotorLabel.text = stringKataKotor
            }
            if let kalimat = riwayatItem.kalimat {
                kalimatLabel.text = kalimat
            }
            if let timestamp = riwayatItem.waktu {
                timestampLabel.text = Converter.convertDateToStringDateHourMinute(date: timestamp)
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        view.layer.cornerRadius = 14
        let maskLayer = CALayer()
        let verticalPadding: CGFloat = 13
        maskLayer.cornerRadius = 10
        maskLayer.backgroundColor = UIColor.black.cgColor
        maskLayer.frame = CGRect(x: self.bounds.origin.x, y: self.bounds.origin.y, width: self.bounds.width, height: self.bounds.height).insetBy(dx: 0, dy: verticalPadding/2)
        self.layer.mask = maskLayer
        self.selectedBackgroundView = .none

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
