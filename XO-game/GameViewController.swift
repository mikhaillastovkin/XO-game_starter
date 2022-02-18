//
//  GameViewController.swift
//  XO-game
//
//  Created by Evgeny Kireev on 25/02/2019.
//  Copyright © 2019 plasmon. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {

    @IBOutlet var gameboardView: GameboardView!
    @IBOutlet var firstPlayerTurnLabel: UILabel!
    @IBOutlet var secondPlayerTurnLabel: UILabel!
    @IBOutlet var winnerLabel: UILabel!
    @IBOutlet var restartButton: UIButton!

    private let gameboard = Gameboard()
    var currentState: GameState! {
        didSet {
            self.currentState.begin()
        }
    }
    private lazy var referee = Referee(gameboard: self.gameboard)
    private var counter: Int = 0
    var state: State?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.goToFirstState()

        gameboardView.onSelectPosition = { [weak self] position in
            guard let self = self else { return }
            self.counter += 1
            self.currentState.addMark(at: position)
            if self.currentState.isCompleted,
               self.state != .fiveToFive {
                self.goToNextState()
            } else {
                self.goToNextFiveState()
            }
        }
    }


    private func goToFirstState() {
        guard let state = state
        else { return }
        switch state {
        case .human:
            self.currentState = PlayerInputState(player: .first,
                                                 gameViewController: self,
                                                 gameboard: gameboard,
                                                 gameboardView: gameboardView)
        case .computer:
            self.currentState = ComputerPlayerState(player: .first,
                                                    gameViewController: self,
                                                    gameboard: gameboard,
                                                    gameboardView: gameboardView)
        case .fiveToFive:
            self.currentState = FiveToFiveState(player: .first,
                                                gameViewController: self,
                                                gameboard: gameboard,
                                                gameboardView: gameboardView)

        }
    }

    private func goToNextState() {
        if let winner = self.referee.determineWinner() {
            self.currentState = GameEndedState(winner: winner, gameViewController: self)
            return
        }

        if counter >= 9 {
            currentState = GameEndedState(winner: nil, gameViewController: self)
            return
        }

        if let playerInputState = currentState as? PlayerInputState {
            self.currentState = PlayerInputState(player: playerInputState.player.next,
                                                 gameViewController: self,
                                                 gameboard: gameboard,
                                                 gameboardView: gameboardView)
            return
        }
        if let computerPlayerState = currentState as? ComputerPlayerState {
            self.currentState = ComputerPlayerState(player: computerPlayerState.player.next,
                                                 gameViewController: self,
                                                 gameboard: gameboard,
                                                 gameboardView: gameboardView)
            return
            
        }

    }

    private func goToNextFiveState() {

        switch counter {
        case 1...4:
            self.currentState = FiveToFiveState(player: .first,
                                                gameViewController: self,
                                                gameboard: gameboard,
                                                gameboardView: gameboardView)
        case 5:
            gameboard.clear()
            gameboardView.clear()
            self.currentState = FiveToFiveState(player: .second,
                                                gameViewController: self,
                                                gameboard: gameboard,
                                                gameboardView: gameboardView)
        case 5...9:
            self.currentState = FiveToFiveState(player: .second,
                                                gameViewController: self,
                                                gameboard: gameboard,
                                                gameboardView: gameboardView)
        case 10:
            self.currentState = FiveToFiveState(player: .second,
                                                gameViewController: self,
                                                gameboard: gameboard,
                                                gameboardView: gameboardView)
            gameboard.clear()
            gameboardView.clear()
            CommandManager.shared.processExecuteCommand()
            if let winner = self.referee.determineWinner() {
                self.currentState = GameEndedState(winner: winner, gameViewController: self)
            } else {
                currentState = GameEndedState(winner: nil, gameViewController: self)
            }
        default: break
        }
    }

    
    @IBAction func restartButtonTapped(_ sender: UIButton) {
        gameboardView.clear()
        gameboard.clear()
        goToFirstState()
        counter = 0
    }
}

