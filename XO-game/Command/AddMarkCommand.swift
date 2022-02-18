//
//  AddMarkCommand.swift
//  XO-game
//
//  Created by Михаил Ластовкин on 18.02.2022.
//  Copyright © 2022 plasmon. All rights reserved.
//

import Foundation

class AddMarkCommand: Command {

    var isCopleted: Bool = false
    var player: Player
    var position: GameboardPosition
    var gameBoard: Gameboard
    var gameBoardView: GameboardView

    init (player: Player, position: GameboardPosition, gameBoard: Gameboard, gameBoardView: GameboardView) {
        self.player = player
        self.position = position
        self.gameBoard = gameBoard
        self.gameBoardView = gameBoardView
    }


    func execute() {

        let markView: MarkView
        switch self.player {
        case .first:
            markView = XView()
            self.gameBoard.setPlayer(self.player, at: position)
            self.gameBoardView.placeMarkView(markView, at: position)
            self.isCopleted = true
        case .second:
            if !gameBoardView.canPlaceMarkView(at: position) {
                gameBoardView.removeMarkView(at: position)
            }
            markView = OView()
            self.gameBoard.setPlayer(self.player, at: position )
            self.gameBoardView.placeMarkView(markView, at: position)
            self.isCopleted = true
        }
    }
}
