//
//  InfoTableViewCell.swift
//  RainBowBridge
//
//  Created by Julian on 2021/10/13.
//

import UIKit

class InfoTableViewCell: UITableViewCell {
    @IBOutlet var logo: UIImageView!
    @IBOutlet var name: UILabel!
    @IBOutlet var identifier: UILabel!
    @IBOutlet var version: UILabel!
    @IBOutlet var buildVersion: UILabel!
    @IBOutlet var time: UILabel!
    @IBOutlet var btn: UIButton! {
        didSet {
            btn.layer.cornerRadius = 5
            btn.layer.masksToBounds = true
        }
    }

    var model: AnyObject?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        logo.layer.cornerRadius = 8
        logo.layer.masksToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configBy(_ model: AnyObject) {
        self.model = model

        name.text = model["buildName"] as? String
        identifier.text = model["buildIdentifier"] as? String
        version.text = "版本号：" + (model["buildVersion"] as? String ?? "")
        buildVersion.text = "构建号：" + (model["buildBuildVersion"] as? String ?? "")
        time.text = model["buildCreated"] as? String
    }

    @IBAction func toggle(_ sender: Any) {
        guard let buildKey = self.model?["buildKey"] as? String else { return }
        let path = "itms-services://?action=download-manifest&url=https://www.pgyer.com/app/plist/" + buildKey
        if let url = URL(string: path) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
}
