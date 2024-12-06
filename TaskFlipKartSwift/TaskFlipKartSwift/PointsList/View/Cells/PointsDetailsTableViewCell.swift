//
//  PointsDetailsTableViewCell.swift
//  TaskFlipKartSwift
//
//  Created by Kishore B on 12/6/24.
//

import UIKit

class PointsDetailsTableViewCell: UITableViewCell {

    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var playerNameLabel: UILabel!
    @IBOutlet weak var pointsLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configure(with entry: PointsTableEntry) {
        playerNameLabel.text = entry.player.name
        pointsLabel.text = "\(entry.points) points"
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
