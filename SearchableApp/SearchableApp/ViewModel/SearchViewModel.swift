

import Foundation

class SearchViewModel {
    
    var delegate : SearchViewModelDelegate?
    var news = [Item]()
    
    func fetchNews(_ query: String = ""){
        
        NetworkProvider.shared.getNews(query: query) { [weak self] data, response, error in
            guard let data = data else { return }
            guard let jsonData = try? JSONDecoder().decode(SearchDTO.self, from: data) else { return }
            self?.news = jsonData.items
            self?.delegate?.updateData()
            
        }.resume()
    
    }
    
}
