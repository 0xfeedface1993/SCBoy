//
//  TodayViewController.swift
//  SCToday
//
//  Created by virus1994 on 2019/4/24.
//  Copyright © 2019 ascp. All rights reserved.
//

import UIKit
import NotificationCenter

class TodayViewController: UIViewController, NCWidgetProviding {
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let playerA = UILabel()
        let playerB = UILabel()
        let race = UIButton()
        
        let scoreA = UIButton()
        let scoreB = UIButton()
        
        let date = UILabel()
        let state = UILabel()
        
        date.font = UIFont.systemFont(ofSize: 12)
        date.textColor = .lightGray
        date.text = "2019-04-24"
        state.textColor = .red
        state.font = UIFont.boldSystemFont(ofSize: 14)
        state.text = "比赛中"
        
        playerA.text = "Maru"
        playerA.font = UIFont.boldSystemFont(ofSize: 18)
        playerA.textAlignment = .center
        playerB.text = "Scarllet"
        playerB.font = UIFont.boldSystemFont(ofSize: 18)
        playerB.textAlignment = .center
        
        race.setTitle("TvZ", for: .normal)
        race.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        race.setTitleColor(.gray, for: .normal)
        race.contentEdgeInsets = UIEdgeInsets(top: 6, left: 8, bottom: 6, right: 8)
        race.backgroundColor = .clear
        race.layer.borderColor = UIColor.gray.cgColor
        race.layer.borderWidth = 0.5
        race.layer.cornerRadius = 6
        
        scoreA.setTitle("1", for: .normal)
        scoreA.setTitleColor(.black, for: .normal)
        scoreA.backgroundColor = .clear
        scoreA.layer.cornerRadius = 16
        
        scoreB.setTitle("0", for: .normal)
        scoreB.setTitleColor(.lightGray, for: .normal)
        scoreB.backgroundColor = .clear
        scoreB.layer.cornerRadius = 16
        
        view.addSubview(playerA)
        view.addSubview(playerB)
        view.addSubview(race)
        view.addSubview(scoreA)
        view.addSubview(scoreB)
        view.addSubview(state)
        view.addSubview(date)
        
        let views: [String:UIView] = ["a": playerA, "b": playerB, "btn": race, "sa": scoreA, "sb": scoreB, "d": date, "s": state]
        let metrics = ["mw": (UIScreen.main.bounds.size.width - 100.0) / 2.0]
        views.forEach({ $0.value.translatesAutoresizingMaskIntoConstraints = false })
        
        
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[a]-[sa(>=32)]-[btn]-[sb(>=32)]-[b(a)]-|", options: .alignAllCenterY, metrics: metrics, views: views))
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[d]-[btn(28)]-[s(d)]-|", options: .alignAllCenterX, metrics: nil, views: views))
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "V:[sa(32)]", options: [], metrics: nil, views: views))
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "V:[sb(sa)]", options: [], metrics: nil, views: views))
    }
        
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.
        
        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData
        
        completionHandler(NCUpdateResult.newData)
    }
    
}
