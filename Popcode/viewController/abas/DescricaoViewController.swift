//
//  DescricaoViewController.swift
//  Popcode
//
//  Created by Jayme Antonio da Rosa Caironi on 06/03/21.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth
import FirebaseUI

class DescricaoViewController: UIViewController {
    
    var firestore: Firestore!
    var filme: Filme!
    var auth: Auth!
    var idUsuarioLogado: String!
    
    
    @IBOutlet weak var imagemFilme: UIImageView!
    @IBOutlet weak var nomeFilme: UILabel!
    @IBOutlet weak var anoFilme: UILabel!
    @IBOutlet weak var generoFilme: UILabel!
    @IBOutlet weak var descricaoFilme: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        auth = Auth.auth()
        firestore = Firestore.firestore()
        
//        imagemFilme = filme
        imagemFilme.sd_setImage(with: URL(string: filme.url ?? ""), completed: nil)
        nomeFilme.text = filme.nome
        anoFilme.text = filme.ano
        generoFilme.text = filme.genero
        descricaoFilme.text = filme.descricao
        
        if let idUsuario = auth.currentUser?.uid {
            self.idUsuarioLogado = idUsuario
        }
        
    }
    
    
    @IBAction func favoritoButton(_ sender: Any) {
        
        filme.nome = nomeFilme.text
        filme.ano = anoFilme.text
        filme.genero = generoFilme.text
        filme.descricao = descricaoFilme.text
        imagemFilme.sd_setImage(with: URL(string: filme.url ?? ""), completed: nil)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "segueDescricao" {
//            if let indexPath = tableView.indexPathForSelectedRow {
//                let filmeSelecionado = self.filmes[ indexPath.row ]
//
//                let viewControllerDestino = segue.destination as! DetalhesFilmeViewController
//                viewControllerDestino.filme = filmeSelecionado
//
//            }
        }
        
    }
    
    /*Metodos para listagem*/
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
