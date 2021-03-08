//
//  Filme.swift
//  Popcode
//
//  Created by Jayme Antonio da Rosa Caironi on 07/03/21.
//

import Foundation

class Filme {

    var nome: String?
    var url: String?
    var ano: String?
    var genero: String?
    var descricao: String?

    init(dictionary: [String: Any]) {
        self.nome = dictionary["nome"] as? String
        self.url = dictionary["url"] as? String
        self.ano = dictionary["ano"] as? String
        self.genero = dictionary["genero"] as? String
        self.descricao = dictionary["descricao"] as? String
    }
}
