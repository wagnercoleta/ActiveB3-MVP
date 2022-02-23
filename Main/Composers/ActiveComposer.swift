//
//  ActiveComposer.swift
//  Main
//
//  Created by Wagner Coleta on 23/02/22.
//

import Foundation
import Domain
import UI

public final class ActiveComposer {
    static func composeControllerWith(readActive: ReadActive) -> ActiveViewController {
        return ControllerFactory.makeActiveController(readActive: readActive)
    }
}
