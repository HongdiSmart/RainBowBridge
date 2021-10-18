//
//  ViewController.swift
//  RainBowBridge
//
//  Created by Julian on 2021/10/13.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var tableView: UITableView!

    var dataArray = [AnyObject]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        NotificationCenter.default.addObserver(self, selector: #selector(applicationDidBecomeActive(_:)), name: UIApplication.didBecomeActiveNotification, object: nil)
    }

    @objc private func applicationDidBecomeActive(_ notification: NSNotification?) {
        ApplicationFlow.sync("b5b4a52868ef132087835ca2430728a4", appKey: "e5cf6de8b7446b09524378cfbeb515b2") { result, _ in
            if result != nil {
                self.dataArray = result as! [AnyObject]
                self.tableView.reloadData()
            }
        }
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "InfoTableViewCell") as? InfoTableViewCell {
            cell.configBy(dataArray[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
}

extension ViewController: UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}
