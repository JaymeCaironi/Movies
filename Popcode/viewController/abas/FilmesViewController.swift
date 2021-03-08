//
//  FilmesViewController.swift
//  Popcode
//
//  Created by Jayme Antonio da Rosa Caironi on 06/03/21.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth
import FirebaseUI

class FilmesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    @IBOutlet weak var searchBarFilme: UISearchBar!
    @IBOutlet weak var tableViewFilmes: UITableView!
    var firestore: Firestore!
    var auth: Auth!
    var filmes: [Filme] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableViewFilmes.separatorStyle = .none
        
        firestore = Firestore.firestore()
        auth = Auth.auth()
        self.searchBarFilme.delegate = self
        

        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        recuperarFilmes()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            recuperarFilmes()
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        if let textoPesquisa = searchBar.text {
            if textoPesquisa != "" {
                pesquisarFilmes(texto: textoPesquisa)
            }
        } else{
            
/*          var listaFiltro: [Filme] = self.filmes
            self.filmes.removeAll()
            
            let erroPesquisa = UILabel(frame: CGRect(x: 20, y: 300, width: 375, height: 250))
            erroPesquisa.center = CGPoint(x: 160, y: 285)
            erroPesquisa.textAlignment = .center
            erroPesquisa.text = "Sua pesquisa por este Filme não encontrou algum correspondente"
            self.view.addSubview(erroPesquisa) */
        }
    }
    
    func pesquisarFilmes(texto: String) {
        var listaFiltro: [Filme] = self.filmes
        self.filmes.removeAll()
        
        for item in listaFiltro {
            if let data = item.ano {
                if data.lowercased().contains(texto.lowercased()){
                    self.filmes.append(item)
                }
            }
        }
        
        for item in listaFiltro {
            if let nome = item.nome {
                if nome.lowercased().contains(texto.lowercased()){
                    self.filmes.append(item)
                }
            }
        }
        
        self.tableViewFilmes.reloadData()
    }
    
    /*Metodos para listagem na Tabela*/
    
    func recuperarFilmes() {
        
        //Limpar listagem de Filmes
        self.filmes.removeAll()
        self.tableViewFilmes.reloadData()
        
        firestore.collection("filmes").getDocuments { (snapshotResultado, erro) in
            
            if let snapshot = snapshotResultado {
                for document in snapshot.documents {
                    let dados = document.data()
                    self.filmes.append(Filme(dictionary: dados))
                }
                self.tableViewFilmes.reloadData()
            }
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let noDataLabel: UILabel  = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: tableView.bounds.size.height))
            noDataLabel.text          = "Sua busca não foi encontrada"
            noDataLabel.textColor     = UIColor.black
            noDataLabel.textAlignment = .center
            tableView.backgroundView  = noDataLabel
            tableView.separatorStyle  = .none
        
        return self.filmes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let celula = tableView.dequeueReusableCell(withIdentifier: "celulaFilmes", for: indexPath) as! FilmesTableViewCell
        
        let indice = indexPath.row
        let filme = self.filmes[indice]
        celula.setup(filme: filme)
        return celula
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "segueDescricao" {
            let cell = sender as! FilmesTableViewCell
            let viewDestino = segue.destination as! DescricaoViewController
            
            viewDestino.filme = cell.filme
            
        }
        
        
        
        
        /*if segue.identifier == "segueDescricao" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let filmeSelecionado = self.filmes[ indexPath.row ]
                
        let viewDestino = segue.destination as! DescricaoViewController*/
                
            //viewDestino.filmes = sender as? Dictionary
            
            //}
        }
        
    

}
