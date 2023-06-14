
import UIKit

class MainViewController : UIViewController {
    
    private var searchButton = UIButton()
    
    override func viewDidLoad() {
        initAttribute()
        initLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    func initAttribute(){
        
        view.backgroundColor = .white
        searchButton.setTitle("검색어를 입력해주세요", for: .normal)
        searchButton.backgroundColor = .lightGray
        searchButton.layer.cornerRadius = 15
        searchButton.addTarget(self, action: #selector(tapSearchButton), for: .touchUpInside)
    }
    
    func initLayout() {
        view.addSubview(searchButton)
        
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            searchButton.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchButton.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            searchButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchButton.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    @objc func tapSearchButton(){
        navigationController?.pushViewController(SearchViewController(), animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
}
