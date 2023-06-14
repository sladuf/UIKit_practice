

import UIKit

class SearchViewController: UIViewController {
    
    var viewModel = SearchViewModel()
    
    lazy var searchBar = UISearchBar()
    lazy var tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        initAttribute()
        initLayout()
    }
    
    func initAttribute(){
        viewModel.delegate = self
        
        searchBar.placeholder = "검색어를 입력하세요"
        searchBar.delegate = self
        
        tableView.backgroundColor = .clear
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CustomTableViewCell.classForCoder(), forCellReuseIdentifier: CustomTableViewCell.id)
        
        navigationController?.navigationBar.topItem?.title = ""
        self.navigationItem.titleView = searchBar
        
    }
    
    func initLayout(){
        
//        searchBar.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
//            searchBar.heightAnchor.constraint(equalToConstant: 50)
//        ])
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

}

extension SearchViewController : UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("search word : \(searchBar.text ?? "empty")")
        viewModel.fetchNews(searchBar.text ?? "")
    }
}

extension SearchViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.news.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.id) as! CustomTableViewCell
        cell.bind(viewModel.news[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}

extension SearchViewController : SearchViewModelDelegate {
    func updateData() {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
}
