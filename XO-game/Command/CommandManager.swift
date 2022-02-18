//
//  CommandManager.swift
//  XO-game
//
//  Created by Михаил Ластовкин on 18.02.2022.
//  Copyright © 2022 plasmon. All rights reserved.
//

import Foundation

class CommandManager {

    static var shared = CommandManager()
    private var commands = [Command]()

    private init() { }

    func addCommand(_ command: Command) {
        self.commands.append(command)
    }

    func processExecuteCommand() {
        commands.filter { $0.isCopleted == false }.forEach { $0.execute() }
    }
}
