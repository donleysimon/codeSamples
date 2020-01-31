

import UIKit

class TipoBuscaViewController: BaseViewController {

    // MARK: - OutLets
    
    @IBOutlet weak var lbNomeServico: UILabel!
    @IBOutlet weak var btnFluxoData: UIButton!
    @IBOutlet weak var btnFluxoLocal: UIButton!
    
    // MARK: - Variables

    var servicoSelecionado: SchedulerServiceModel?
    var tipoDeBusca: String?
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mostarServico()
        self.alertCTPS()
    }
    
    // MARK: - Actions
    
    @IBAction func fluxoData(_ sender: Any) {
        
        self.tipoDeBusca = "porData"
        self.performSegue(withIdentifier: "segueData", sender: nil)
        
    }
    
    @IBAction func fluxoLocal(_ sender: Any) {
        
        self.tipoDeBusca = "porLocal"
        self.performSegue(withIdentifier: "segueLocal", sender: nil)
        
    }
    
    
    
    // MARK: - Functions
    
    func mostarServico(){
        
        lbNomeServico.text = servicoSelecionado?.nome
    }
    
    func alertCTPS(){
        
        if servicoSelecionado?.identificador == 47 {
            let alerta = UIAlertController(title: "Atenção", message: "xxxxxxxx", preferredStyle: .alert)
            let actionAgendar = UIAlertAction(title: "xxxxxx", style: .cancel, handler: nil)
            let actionLoja = UIAlertAction(title: "xxxxxxxx", style: .default, handler: { (UIAlertAction) in
                if let url = URL(string: "xxxxxxxxx") {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }
            })
            alerta.addAction(actionAgendar)
            alerta.addAction(actionLoja)
            self.present(alerta, animated: true, completion: nil)
            
        }
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if(segue.identifier == "segueData"){
            let tela = segue.destination as! DatasAgendamentoViewController
            tela.tipoDeBusca        = self.tipoDeBusca
            tela.servicoSelecionado = self.servicoSelecionado
            
        }
        
        if(segue.identifier == "segueLocal"){
            let tabBarController = segue.destination as! tabBarController
            tabBarController.servicoSelecionado = self.servicoSelecionado
            tabBarController.tipoBusca = self.tipoDeBusca
            
            let destinationViewController = tabBarController.viewControllers![0] as! LocalViewController
            destinationViewController.servicoSelecionado = self.servicoSelecionado
            destinationViewController.tipoBusca = self.tipoDeBusca
            
        }
    }
}
