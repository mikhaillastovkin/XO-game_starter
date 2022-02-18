//
//  Command.swift
//  XO-game
//
//  Created by Михаил Ластовкин on 18.02.2022.
//  Copyright © 2022 plasmon. All rights reserved.
//

import Foundation

protocol Command {
    var isCopleted: Bool { get set }
    func execute()
}
