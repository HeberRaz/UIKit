//
//  PokedexMainRemoteDataManagerMock.swift
//  PokedexTests
//
//  Created by Ivan Tecpanecatl Martinez on 16/11/22.
//

import Foundation
@testable import Pokedex

enum PokedexMainRemoteDataManagerCalls{
    case requestPokemonBlock
    case requestPokemonName
    case requestImageData
}

class PokedexMainRemoteDataManagerMock: PokedexMainRemoteDataInputProtocol {

    var interactor: PokedexRemoteDataOutputProtocol?
    var calls:[PokedexMainRemoteDataManagerCalls] = []
    
    func requestPokemonBlock(_ urlString: String?) {
        calls.append(.requestPokemonBlock)
    }
    
    func requestPokemon(_ name: String) {
        calls.append(.requestPokemonName)
    }

    func requestImageData(urlString: String, completion: @escaping (Data?) -> Void) {
        calls.append(.requestImageData)
    }
}
