

class SchedulerRepository: baseRepository {
    
    /**
    Retorna as datas disponíveis para agendamento do serviço selecionado dentro das datas informadas
    
    - Author:
    Peter Simon
    
    - parameters:
       - id: O ID do serviço selecionado em formato Int
       - start: Data inicial em formato String (yyyyMMdd)
       - end: Data final em formato String (yyyyMMdd)
       - completion: Retorna o código HTTP e um array de datas
    
    - Important: O retorno dessa função se faz através de completions
    
    */
    func getServicesAvailability(id: Int, start: String, end: String, _ completion: @escaping (Int, [Date]?) -> Void) {
        let urlStr = Util.urlBase() + String(format: Constantes.scheduleAvailability, String(id), start, end)
        get(urlStr, params: nil, headers: nil) {
            code, data, erro in
            var response: [Date] = []
            if let data = data {
                if let model = try? self.newJSONDecoder().decode([String].self, from: data) {
                    for item in model {
                        response.append(Util.convertStringToDateOtherFormat(date: item, format: "yyyyMMdd"))
                    }
                }
            }
            completion(code, response)
        }
    }
    
    /**
    Retorna as datas disponíveis para agendamento no local selecionado
    
    - Author:
    Peter Simon
    
    - parameters:
       - id: O ID do serviço selecionado em formato Int
       - idOrgao: O ID do orgão selecionado em formato Int
       - idLocal: O ID do local selecionado em formato Int
       - completion: Retorna o código HTTP e um array de datas
    
    - Important: O retorno dessa função se faz através de completions
    
    */
    func getServicesAvailabilitySite(id: Int, idOrgao: Int, idLocal: Int, _ completion: @escaping (Int, [Date]?) -> Void) {
        let urlStr = Util.urlBase() + String(format: Constantes.scheduleAvailabilitySite, String(idOrgao), String(idLocal), String(id))
        get(urlStr, params: nil, headers: nil) {
            code, data, erro in
            var response: [Date] = []
            if let data = data {
                if let model = try? self.newJSONDecoder().decode([String].self, from: data) {
                    for item in model {
                        response.append(Util.convertStringToDateOtherFormat(date: item, format: "yyyyMMdd"))
                    }
                }
            }
            completion(code, response)
        }
    }
    
    /**
     Retorna os locais disponíveis para agendamento na data selecionada
     
     - Author:
     Peter Simon
     
     - parameters:
        - id: O ID do serviço selecionado em formato Int
        - data: A data selecionada em formato String (yyyyMMdd)
        - completion: Retorna o código HTTP e um array de locais [LocalTO]
     
     - Important: O retorno dessa função se faz através de completions
     
     */
    func getSitesAvailabilityForDate(id: Int, data: String, _ completion: @escaping (Int, [LocalTO]?) -> Void) {
        let urlStr = Util.urlBase() + String(format: Constantes.scheduleAvailabilitySiteForDate, String(id), data)
        get(urlStr, params: nil, headers: nil) {
            code, data, erro in
            var response: [LocalTO] = []
            if let data = data {
                if let model = try? self.newJSONDecoder().decode([LocalTO].self, from: data) {
                    for item in model {
                        response.append(item)
                    }
                }
            }
            completion(code, response)
        }
    }
    
    /**
     Retorna os horarios disponíveis para agendamento na data e local selecionados
     
     - Author:
     Peter Simon
     
     - parameters:
        - idServico: O ID do serviço selecionado em formato Int
        - idOrgao: O ID do orgão selecionado em formato Int
        - idLocal: O ID do local selecionado em formato Int
        - data: A data selecionada em formato String (yyyyMMdd)
        - completion: Retorna o código HTTP e um array de HorarioTO
     
     - Important: O retorno dessa função se faz através de completions
     
     */
    func getScheduleAvailabilityForSiteAndDate(idServico: Int, idOrgao: Int, idLocal: Int, data: String, _ completion: @escaping (Int, [HorarioTO]?) -> Void) {
        let urlStr = Util.urlBase() + String(format: Constantes.scheduleAvailabilityForSiteAndDate, String(idOrgao), String(idLocal), String(idServico), data)
        get(urlStr, params: nil, headers: nil) {
            code, data, erro in
            var response: [HorarioTO] = []
            if let data = data {
                if let model = try? self.newJSONDecoder().decode([HorarioTO].self, from: data) {
                    for item in model {
                        response.append(item)
                    }
                }
            }
            completion(code, response)
        }
    }
    
    /**
    Retorna os locais disponíveis para agendamento
    
    - Author:
    Peter Simon
    
    - parameters:
       - idOrgao: O ID do orgão selecionado em formato Int
       - completion: Retorna o código HTTP e um array de locais [LocalTO]
    
    - Important: O retorno dessa função se faz através de completions
    
    */
    func getSites(idOrgao: Int, _ completion: @escaping (Int, [LocalTO]?) -> Void) {
        let urlStr = Util.urlBase() + String(format: Constantes.scheduleSites, String(idOrgao))
        get(urlStr, params: nil, headers: nil) {
            code, data, erro in
            var response: [LocalTO] = []
            if let data = data {
                if let model = try? self.newJSONDecoder().decode([LocalTO].self, from: data) {
                    for item in model {
                        response.append(item)
                    }
                }
            }
            completion(code, response)
        }
    }
    
    /**
    Confirma o agendamento e retorna o código HTTP
    
    - Author:
    Peter Simon
    
    - parameters:
       - agendamentoData: Um array com as informações do atendimento em formato [String:Any]
       - completion: Retorna o código HTTP e uma mensagem de resposta
    
    - Important: O retorno dessa função se faz através de completions
    
    */
    func putScheduleConfirmation(agendamentoData: [String:Any], _ completion: @escaping (Int, String, String?) -> Void) {
        let urlStr = Util.urlBase() + String(format: Constantes.scheduleConfirmation)
        put(urlStr, params: agendamentoData, requestType: .json, headers: nil) {
            code, data, erro in
            var response = ""
            if let data = data {
                response = String(data: data, encoding: .utf8) ?? ""
                // print("code: \(code), data: \(response)")
            }else{
                // print("code: \(code), data nulo")
            }
            completion(code, response, erro)
        }
    }
    
    /**
    Exclui o agendamento informado e retorna um código
    
    - Author:
    Peter Simon
    
    - parameters:
       - idCidadao: O ID do cidadão em formato String
       - idAtendimento: O ID do atendimento em formato String
       - completion: Retorna o código HTTP uma mensagem e um erro
    
    - Important: O retorno dessa função se faz através de completions
    
    */
    func deleteSchedule(idCidadao: String, idAtendimento: String, _ completion: @escaping (Int, String?) -> Void) {
        let urlStr = Util.urlBase() + String(format: Constantes.scheduleDeletion, idAtendimento, idCidadao)
        delete(urlStr, params: nil, requestType: nil, headers: nil){
            code, data, erro in
            if let data = data {
                if let model = try? self.newJSONDecoder().decode(String.self, from: data) {
                    completion(code, model)
                }
            }
            completion(code, nil)
        }
    }
    
}
