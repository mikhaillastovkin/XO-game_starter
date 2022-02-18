//
//  ComputerPlayerState.swift
//  XO-game
//
//  Created by Михаил Ластовкин on 14.02.2022.
//  Copyright © 2022 plasmon. All rights reserved.
//

import Foundation

class ComputerPlayerState: GameState {

    public private(set) var isCompleted = false

    public let player: Player
    private(set) weak var gameViewController: GameViewController?
    private(set) weak var gameboard: Gameboard?
    private(set) weak var gameboardView: GameboardView?

    init(player: Player, gameViewController: GameViewController, gameboard: Gameboard, gameboardView: GameboardView) {
        self.player = player
        self.gameViewController = gameViewController
        self.gameboard = gameboard
        self.gameboardView = gameboardView
    }

    func begin() {
        self.gameViewController?.secondPlayerTurnLabel.text = "Computer"
        switch self.player {
        case .first:
            self.gameViewController?.firstPlayerTurnLabel.isHidden = false
            self.gameViewController?.secondPlayerTurnLabel.isHidden = true
        case .second:
            self.gameViewController?.firstPlayerTurnLabel.isHidden = true
            self.gameViewController?.secondPlayerTurnLabel.isHidden = false
            let computerPosition = randomPosition()
                       gameboardView?.onSelectPosition?(computerPosition)

        }
        self.gameViewController?.winnerLabel.isHidden = true

    }

    func addMark(at position: GameboardPosition) {
        guard let gameboardView = self.gameboardView,
              gameboardView.canPlaceMarkView(at: position)
        else { return }

        let markView: MarkView
        switch self.player {
        case .first:
            markView = XView()
            self.gameboard?.setPlayer(self.player, at: position)
            self.gameboardView?.placeMarkView(markView, at: position)
            self.isCompleted = true
        case .second:
            markView = OView()
            self.gameboard?.setPlayer(self.player, at: position )
            self.gameboardView?.placeMarkView(markView, at: position)
            self.isCompleted = true

        }
    }

    private func randomPosition() -> GameboardPosition {
        let randomColumn = Int.random(in: 0..<GameboardSize.columns)
        let randomRow = Int.random(in: 0..<GameboardSize.rows)

        guard let gameboardView = self.gameboardView,
            gameboardView.canPlaceMarkView(at: GameboardPosition(column: randomColumn, row: randomRow))
        else {
            return randomPosition()
        }
        return GameboardPosition(column: randomColumn, row: randomRow)
    }

}
