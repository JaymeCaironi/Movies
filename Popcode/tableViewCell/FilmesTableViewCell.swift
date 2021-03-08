//
//  FilmesTableViewCell.swift
//  Popcode
//
//  Created by Jayme Antonio da Rosa Caironi on 06/03/21.
//

import UIKit

class FilmesTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var fotoFilme: UIImageView!
    
    @IBOutlet weak var nomeFilme: UILabel!

    var filme: Filme!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setup(filme: Filme) {
        self.filme = filme
        fotoFilme.sd_setImage(with: URL(string: filme.url ?? ""), completed: nil)
        self.nomeFilme.text = filme.nome
    }
    
    
    @IBAction func favoriteCell(_ sender: Any) {
        
        print("Botão Salvo")
        
    }
    
}
