//
//  MatchesListViewModel.swift
//  TaskFlipKartSwift
//
//  Created by Kishore B on 12/6/24.
//

import Foundation
import UIKit


class MatchesListViewModel {
    let player: Player
    let matches: [MatchResponse]
    let players: [Player]
    
    init(player: Player, matches: [MatchResponse], players: [Player]) {
        self.player = player
        self.matches = matches
        self.players = players
    }
    
    func getPlayerName(by id: Int) -> String {
        players.first(where: { $0.id == id })?.name ?? "Unknown"
    }
    
    var filteredMatches: [MatchResponse] {
        matches.filter { $0.player1.id == player.id || $0.player2.id == player.id }
            .sorted { $0.match > $1.match } // Sort by most recent match first
    }
    
    func configureCell(for match: MatchResponse) -> (player1Name: String, opponentName: String, playerScore: Int, opponentScore: Int, backgroundColor: UIColor) {
        let player1Name = getPlayerName(by: match.player1.id)
        let player2Name = getPlayerName(by: match.player2.id)
        let isPlayer1 = match.player1.id == player.id
        let playerScore = isPlayer1 ? match.player1.score : match.player2.score
        let opponentScore = isPlayer1 ? match.player2.score : match.player1.score
        let backgroundColor: UIColor = playerScore > opponentScore ? .green : (playerScore < opponentScore ? .red : .white)
        
        return (player1Name, player2Name, playerScore, opponentScore, backgroundColor)
    }
}
