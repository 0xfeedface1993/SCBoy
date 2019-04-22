//
//  MatchViewController.swift
//  SCBoy
//
//  Created by virus1994 on 2019/4/22.
//  Copyright © 2019 ascp. All rights reserved.
//

import UIKit
import SwiftyJSON
import ESPullToRefresh

struct CellTag {
    var identifier : String
    var nibName: String
    static let card = CellTag(identifier: "com.ascp.cell.match.card", nibName: "MatchTableViewCell")
}

typealias NetworkCompletion = (Bool) -> Void

class MatchViewController: UIViewController, Api, Contries {
    let tableView = UITableView(frame: CGRect.zero, style: .plain)
    var list : JSON?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = .red
        
        self.view.addSubview(tableView)
        self.tableView.makeFullFlap()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.separatorStyle = .none
        
        self.tableView.register(UINib.init(nibName: CellTag.card.nibName, bundle: nil), forCellReuseIdentifier: CellTag.card.identifier)
        
        self.tableView.es.addPullToRefresh {
            [weak self] in
            self?.fetch(completion: { (ok) in
                if ok {
                    
                }
                self?.tableView.es.stopPullToRefresh()
            })
        }
        
        fetch(completion: { (ok) in
            if ok {
                
            }
            self.tableView.es.stopPullToRefresh()
        })
    }
    
    func fetch(nextPage: Bool = false, completion: @escaping NetworkCompletion) {
        api(url: APIHostURL.recentMatch.url, params: ["limit":"20", "offset":"0", "order_by":"-date"]) { (data, res, err) in
            if let _ = err {
                completion(false)
                return
            }
            
            guard let d = data else {
                completion(false)
                return
            }
            
            if let z = convert(jsonData: d) {
                self.list = z
            }
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension MatchViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list?["objects"].arrayValue.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellTag.card.identifier, for: indexPath) as! MatchTableViewCell
        guard let item = list?["objects"].arrayValue[indexPath.row] else    {
            return cell
        }
        
        cell.match.text = item["eventobj"]["fullname"].stringValue
        cell.playerA.text = item["pla"]["tag"].stringValue
        cell.playerB.text = item["plb"]["tag"].stringValue
        cell.scoreA.text = item["sca"].stringValue
        cell.scoreB.text = item["scb"].stringValue
        
        if let raceA = Race(rawValue: item["pla"]["race"].stringValue) {
            cell.raceA.image = RaceIcon.icon(race: raceA).image
        }
        
        if let raceB = Race(rawValue: item["plb"]["race"].stringValue) {
            cell.raceB.image = RaceIcon.icon(race: raceB).image
        }
        
        cell.nationA.image = image(forContry: item["pla"]["country"].stringValue)
        cell.nationB.image = image(forContry: item["plb"]["country"].stringValue)
        
        return cell
    }
}
