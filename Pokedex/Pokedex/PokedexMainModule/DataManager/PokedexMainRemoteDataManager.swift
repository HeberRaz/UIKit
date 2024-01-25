//
//  PokedexMainRemoteDataManager.swift
//  Pokedex
//
//  Created by Heber Raziel Alvarez Ruedas on 31/10/22.
//

import Foundation

final class PokedexMainRemoteDataManager {
    
    // MARK: - Protocol properties
    weak var interactor: PokedexRemoteDataOutputProtocol?
    
    private var service: Service
    
    init(service: Service) {
        self.service = service
    }
}

extension PokedexMainRemoteDataManager: PokedexMainRemoteDataInputProtocol {
    func requestPokemonBlock(_ urlString: String?) {
        service.get(Endpoint.next(urlString: urlString ?? Endpoint.baseURL)) { [weak self] (result: Result<PokemonBlock, Error>) in
            switch result {
            case .success(let pokemonBlock):
                self?.interactor?.handlePokemonBlockFetch(pokemonBlock)
            case .failure(let error):
                self?.interactor?.handleService(error: error)
            }
        }
    }

    func requestPokemon(_ name: String) {
        service.get(Endpoint.pokemon(nameOrId: name)) { [weak self] (result: Result<PokemonDetail, Error>) in
            switch result {
            case .success(let pokemonDetail):
                self?.interactor?.handleFetchedPokemon(pokemonDetail)
            case .failure(let error):
                self?.interactor?.handleService(error: error)
            }
        }
    }

    func requestImageData(urlString: String, completion: @escaping (Data?) -> Void) {
        service.fetchImageData(urlString: urlString, completion: completion)
    }
}
