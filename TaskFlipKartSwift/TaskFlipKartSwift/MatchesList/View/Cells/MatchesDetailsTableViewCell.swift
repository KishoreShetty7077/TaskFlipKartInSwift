//
//  MatchesDetailsTableViewCell.swift
//  TaskFlipKartSwift
//
//  Created by Kishore B on 12/6/24.
//

import UIKit

class MatchesDetailsTableViewCell: UITableViewCell {

    @IBOutlet weak var player1NameLabel: UILabel!
    @IBOutlet weak var playersScoreLabel: UILabel!
    @IBOutlet weak var opponentNameLabel: UILabel!

      
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(with data: (player1Name: String, opponentName: String, playerScore: Int, opponentScore: Int, backgroundColor: UIColor)) {
        player1NameLabel.text = data.player1Name
        playersScoreLabel.text = "\(data.opponentScore) - \(data.playerScore)"
        opponentNameLabel.text = data.opponentName
        self.backgroundColor = data.backgroundColor
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
