//
//  MatchTableViewCell.swift
//  SCBoy
//
//  Created by virus1994 on 2019/4/22.
//  Copyright © 2019 ascp. All rights reserved.
//

import UIKit

enum Race: String {
    case t = "T"
    case z = "Z"
    case p = "P"
}

struct RaceIcon {
    var image : UIImage
    static let terran = RaceIcon(image: UIImage(named: "Terren")!)
    static let protoss = RaceIcon(image: UIImage(named: "Protoss")!)
    static let zerg = RaceIcon(image: UIImage(named: "Zerg")!)
    static let icons = [Race.t:RaceIcon.terran, Race.p:RaceIcon.protoss, Race.z:RaceIcon.zerg]
    static func icon(race: Race) -> RaceIcon {
        return icons[race]!
    }
}

class MatchTableViewCell: UITableViewCell {
    @IBOutlet weak var bacgroundImageView: UIImageView!
    @IBOutlet weak var playerAImgeView: UIImageView!
    @IBOutlet weak var playerBImageView: UIImageView!
    @IBOutlet weak var playerA: UILabel!
    @IBOutlet weak var playerB: UILabel!
    @IBOutlet weak var nationA: UIImageView!
    @IBOutlet weak var nationB: UIImageView!
    @IBOutlet weak var match: UILabel!
    @IBOutlet weak var scoreA: UILabel!
    @IBOutlet weak var scoreB: UILabel!
    @IBOutlet weak var state: UILabel!
    @IBOutlet weak var raceA: UIImageView!
    @IBOutlet weak var raceB: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.bacgroundImageView.image = UIImage(named: "Card")?.resizableImage(withCapInsets: UIEdgeInsets(top: 30, left: 30, bottom: 30, right: 30), resizingMode: .stretch)
        self.bacgroundImageView.contentMode = .scaleToFill
        
        self.playerAImgeView.layer.cornerRadius = 22
        self.playerBImageView.layer.cornerRadius = 22
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
