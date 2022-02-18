//
//  FiveToFiveState.swift
//  XO-game
//
//  Created by Михаил Ластовкин on 18.02.2022.
//  Copyright © 2022 plasmon. All rights reserved.
//

import Foundation

class FiveToFiveState: GameState {

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
        switch self.player {
        case .first:
            self.gameViewController?.firstPlayerTurnLabel.isHidden = false
            self.gameViewController?.secondPlayerTurnLabel.isHidden = true
        case .second:
            self.gameViewController?.firstPlayerTurnLabel.isHidden = true
            self.gameViewController?.secondPlayerTurnLabel.isHidden = false
        }
        self.gameViewController?.winnerLabel.isHidden = true
    }

    func addMark(at position: GameboardPosition) {

        guard let gameboardView = self.gameboardView,
              let gameboard = self.gameboard
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

        let markCommand = AddMarkCommand(player: player, position: position, gameBoard: gameboard, gameBoardView: gameboardView)
        CommandManager.shared.addCommand(markCommand)
        isCompleted = true
    }

}
