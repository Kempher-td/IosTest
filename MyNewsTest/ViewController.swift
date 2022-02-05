//
//  ViewController.swift
//  MyNewsTest
//
//  Created by Victor Mashukevich on 4.02.22.
//

import UIKit


class ViewController: UIViewController, ObservableObject   {
    

    var WebView: secondController?
    let NetWorkLayer = NetworkLayer()
    
    private let tableView: UITableView  = {
        
        let table = UITableView()
    
        table.register(NewsTableViewCell.self, forCellReuseIdentifier: NewsTableViewCell.indentifier)
        
        return table
    }()
    
     var articless = [Articles?]()
    
    private var viewModels = [NewsTableViewCellViewModel]()
    override func viewDidLoad() {
      
    
  

        WebView = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "WebView")
       
        super.viewDidLoad()
        view.addSubview(tableView)
     
        
    
        tableView.delegate = self
        tableView.dataSource = self
    
        
        NetWorkLayer.TakeNews { Newsresponse in
            switch Newsresponse {
            case .success(let response):
                self.articless = response
                self.viewModels = response.compactMap({ NewsTableViewCellViewModel(title: $0?.title ?? "" , subtitle: $0?.description ?? "", imageUrl: URL(string: $0?.urlToImage ?? ""), url: URL(string: $0?.url ?? ""))
                })

                DispatchQueue.main.async {
                    
                    self.tableView.reloadData()
                }
            case .failure(let error):
                break
                
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
        
    }


}
extension ViewController: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     
        
        return viewModels.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      guard  let cell = tableView.dequeueReusableCell(withIdentifier: NewsTableViewCell.indentifier, for: indexPath) as? NewsTableViewCell else {
            fatalError()
        }
        
        cell.configure(with: viewModels[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 450
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let article = articless[indexPath.row]
        guard let url = URL(string: article?.url ?? "") else {
            return
        }
        
        guard let full = WebView else {
            return
        }
        
     
        _ = full.view
        navigationController?.show(full, sender: nil)
        full.webview.load(URLRequest(url: url))
  
        
    }
    
}


