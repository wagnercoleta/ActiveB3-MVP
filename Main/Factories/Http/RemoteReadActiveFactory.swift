//
//  UseCaseFactory.swift
//  Main
//
//  Created by Wagner Coleta on 23/02/22.
//

import Foundation
import Data
import Domain

func makeRemoteReadActive(httpClient: HttpClientGet) -> ReadActive {
    let remoteReadActive = RemoteReadActive(url: makeApiUrl(), httpClient: httpClient)
    return MainQueueDispatchDecorator(remoteReadActive)
}

