//
//  PointTableViewModel.swift
//  TaskFlipKartSwift
//
//  Created by Kishore B on 12/6/24.
//

import Foundation

class PointListViewModel {
    
    var players: [Player] = []
    var matches: [MatchResponse] = []
    var pointsTable: [PointsTableEntry] = []
    
    var didEncounterError: ((String) -> Void)?

    func fetchData(completion: @escaping () -> Void) {
        let group = DispatchGroup()

        group.enter()
        ApiManager.shared.fetchData(from: ApiConstants.playersURL, modelType: [Player].self) { [weak self] result in
            switch result {
            case .success(let players):
                self?.players = players
            case .failure(let error):
                self?.didEncounterError?("Failed to fetch players: \(error.localizedDescription)")
            }
            group.leave()
        }

        group.enter()
        ApiManager.shared.fetchData(from: ApiConstants.matchesURL, modelType: [MatchResponse].self) { [weak self] result in
            switch result {
            case .success(let matches):
                self?.matches = matches
            case .failure(let error):
                self?.didEncounterError?("Failed to fetch matches: \(error.localizedDescription)")
            }
            group.leave()
        }

        group.notify(queue: .main) {
            self.calculatePointsTable()
            completion()
        }
    }

    private func calculatePointsTable() {
        var pointsDict: [Int: PointsTableEntry] = [:]

        for player in players {
            pointsDict[player.id] = PointsTableEntry(player: player, points: 0, totalScore: 0)
        }

        for match in matches {
            guard let player1 = pointsDict[match.player1.id], let player2 = pointsDict[match.player2.id] else { continue }

            if match.player1.score > match.player2.score {
                pointsDict[match.player1.id]?.points += 3
            } else if match.player1.score < match.player2.score {
                pointsDict[match.player2.id]?.points += 3
            } else {
                pointsDict[match.player1.id]?.points += 1
                pointsDict[match.player2.id]?.points += 1
            }

            pointsDict[match.player1.id]?.totalScore += match.player1.score
            pointsDict[match.player2.id]?.totalScore += match.player2.score
        }

        pointsTable = Array(pointsDict.values).sorted {
            if $0.points == $1.points {
                return $0.totalScore > $1.totalScore
            }
            return $0.points > $1.points
        }
    }
}
