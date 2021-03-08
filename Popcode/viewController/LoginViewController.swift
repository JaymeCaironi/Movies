//
//  LoginViewController.swift
//  Popcode
//
//  Created by Jayme Antonio da Rosa Caironi on 04/03/21.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {

    @IBOutlet weak var campoEmail: UITextField!
    @IBOutlet weak var campoSenha: UITextField!
    var auth: Auth!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        auth = Auth.auth()
        
        auth.addStateDidChangeListener { (autenticacao, usuario) in
            if usuario != nil {
                self.performSegue(withIdentifier: "segueLoginAutomatico", sender: nil)
            }else{
                print("Usuario não está Logado")
            }
        }
        
    }
    
    @IBAction func unwindToLogin(_ unwindSegue: UIStoryboardSegue) {
        let sourceViewController = unwindSegue.source
        
        do {
            try auth.signOut()
        } catch {
            print("Erro ao deslogar usuario!")
        }
        
    }
    
    @IBAction func logar(_ sender: Any) {

        if let email = campoEmail.text {
            if let senha = campoSenha.text {
                
                
                auth.signIn(withEmail: email, password: senha) { (usuario, erro) in
                    if erro == nil {
                        print("Sucesso ao Logar")
                    }else{
                        let alerta = UIAlertController(title: "Alerta", message: "Erro ao Logar Usuário", preferredStyle: UIAlertController.Style.alert)
                        
                        let botaoOk = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default) { (UIAlertAction) in
                            
                        }
                        
                        alerta.addAction(botaoOk)
                        
                        self.present(alerta, animated: true, completion: nil)
                    }
                }
            }else{
                print("Preencha a Senha")
            }
        }else{
            print("Preencha seu Email")
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
