//
//  ViewController.swift
//  tableViewPagination
//
//  Created by vignesh on 8/13/17.
//  Copyright © 2017 vignesh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var dataArray = [String]()
    var count = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let _ = loadMore()
        
    }


}
extension ViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "pageCell", for: indexPath)
        
        if indexPath.row < self.dataArray.count {
            cell.textLabel?.text = self.dataArray[indexPath.row]
        }else {
            cell.textLabel?.text = "loading...."
            self.insertMore()
            
        }
        return cell
    }
    
    
    func loadMore()->[IndexPath] {
        var paths = [IndexPath]()
        for _ in 0..<20 {
            count += 1
            self.dataArray.append("items:\(count)")
            paths.append(IndexPath(row: self.dataArray.count - 1, section: 0))
        }
        return paths
    }
    
    func insertMore() {
        
        DispatchQueue.global().async {
            let paths = self.loadMore()

        
        OperationQueue.main.addOperation {
            self.tableView.beginUpdates()
            self.tableView.insertRows(at: paths, with: .top)
            self.tableView.endUpdates()
        }
        
        
    }
    }
    
}
