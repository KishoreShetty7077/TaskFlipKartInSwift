//
//  PointsAndMtachesResponseModel.swift
//  TaskFlipKartSwift
//
//  Created by Kishore B on 12/6/24.
//

import Foundation

struct Player: Decodable, Identifiable {
    let id: Int
    let name: String
    let icon: String
}

struct MatchResponse: Codable {
    let match: Int
    let player1, player2: PlayerDetails
}

struct PlayerDetails: Codable {
    let id, score: Int
}

struct PointsTableEntry: Identifiable {
    let id = UUID()
    let player: Player
    var points: Int
    var totalScore: Int
}
