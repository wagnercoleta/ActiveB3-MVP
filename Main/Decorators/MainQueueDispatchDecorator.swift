//
//  MainQueueDispatchDecorator.swift
//  Main
//
//  Created by Wagner Coleta on 26/02/22.
//

import Foundation
import Domain

public final class MainQueueDispatchDecorator<T> {
    private let instance: T
    
    public init(_ instance: T) {
        self.instance = instance
    }
    
    func dispatch(completion: @escaping () -> Void) {
        guard Thread.isMainThread else { return DispatchQueue.main.async {
            completion()
        }}
        completion()
    }
}

extension MainQueueDispatchDecorator: ReadActive where T: ReadActive {
    public func read(readActiveModels: [ReadActiveModel], completion: @escaping (ReadActive.Result) -> Void) {
        instance.read(readActiveModels: readActiveModels) { [weak self] result in
            self?.dispatch {
                completion(result)
            }
        }
    }
}
/*
public class BaseMainQueueDispatchDecorator<T> {
    let instance: T
    
    public init(_ instance: T) {
        self.instance = instance
    }
    
    func dispatch(completion: @escaping () -> Void) {
        guard Thread.isMainThread else { return DispatchQueue.main.async {
            completion()
        }}
        completion()
    }
}

public final class RemoteReadActiveDecorator: BaseMainQueueDispatchDecorator<ReadActive> {
    
    public override init(_ instance: ReadActive){
        super.init(instance)
    }
    
    public func read(readActiveModels: [ReadActiveModel], completion: @escaping (ReadActive.Result) -> Void) {
        instance.read(readActiveModels: readActiveModels) { result in
            self.dispatch {
                completion(result)
            }
        }
    }
}
*/
