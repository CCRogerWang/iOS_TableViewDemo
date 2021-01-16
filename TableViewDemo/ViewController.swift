//
//  ViewController.swift
//  TableViewDemo
//
//  Created by Roger on 2021/1/15.
//

import UIKit

class StickyHeaderViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var sectionHeaderBigMode: Bool = true
    
    let tableViewHeader = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 200))
    var sectionHeight: CGFloat = 200.0
    @IBOutlet weak var customView: UIView!
    @IBOutlet weak var customViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var customViewTopConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(
          UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.contentInsetAdjustmentBehavior = .never
        tableViewHeader.backgroundColor = .black
        tableView.tableHeaderView = tableViewHeader
        setUIForCustomView()
        view.addSubview(customView)
    }

}

extension StickyHeaderViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
 
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as UITableViewCell
        cell.textLabel?.text = "My cell \(indexPath.row)"
        return cell
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row > 30, sectionHeaderBigMode == true {
            sectionHeaderBigMode = false
            setUIForCustomView()
        } else if indexPath.row < 5, sectionHeaderBigMode == false {
            sectionHeaderBigMode = true
            setUIForCustomView()
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print(scrollView.contentOffset.y)
        if scrollView.contentOffset.y < 0 {
            customViewTopConstraint.constant = scrollView.contentOffset.y * -1
        } else {
            customViewTopConstraint.constant = 0.0
        }

    }
}

private extension StickyHeaderViewController {
    func setUIForCustomView() {
        if sectionHeaderBigMode {
            customViewHeightConstraint.constant = 200
            customView.backgroundColor = UIColor.init(red: 1.0, green: 0.0, blue: 0.0, alpha: 0.8)
        } else {
            customViewHeightConstraint.constant = 88
            customView.backgroundColor = UIColor.init(red: 0.0, green: 1.0, blue: 0.0, alpha: 0.8)
        }
    }
}
