//
//  TableViewCell.swift
//  MyNewsTest
//
//  Created by Victor Mashukevich on 4.02.22.
//


import UIKit
import SwiftUI
fileprivate let RealTime = RelativeDateTimeFormatter()
class NewsTableViewCellViewModel: ObservableObject{
    let title: String
    let subtitle: String
    let imageUrl: URL?
    var imageData: Data? = nil
    var url: URL?
    var BookMark: Bool = false
    
    
    init(title: String, subtitle: String, imageUrl: URL?, url: URL?){
        self.title = title
        self.subtitle = subtitle
        self.imageUrl = imageUrl
        self.url = url
    }
}

class NewsTableViewCell: UITableViewCell {
    static let indentifier = "NewsCell"
    private let Newstitlelable: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 15, weight:  .medium)
        return label
    }()
    private let subtitlelable: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = .systemFont(ofSize: 13, weight:  .regular)
        return label
    }()
    private let NewsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor =  .white
     imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    private let Save: UIButton = {
        let button = UIButton()
        return button
    }()
    private let share: UIButton = {
        let button = UIButton()
        return button
    }()
  
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(NewsImageView)
        contentView.addSubview(subtitlelable)
        contentView.addSubview(Newstitlelable)
        contentView.addSubview(Save)
        contentView.addSubview(share)
      
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
    

   
    override func layoutSubviews() {
        super.layoutSubviews()
        Newstitlelable.frame = CGRect(x: NewsImageView.frame.minX + 5 ,
                                      y: NewsImageView.frame.maxY + 5 ,
                                      width: contentView.frame.size.width - 20 ,
                                      height: 40 )
        subtitlelable.frame = CGRect(x: Newstitlelable.frame.minX + 10,
                                     y: Newstitlelable.frame.minY - 50 ,
                                     width: NewsImageView.frame.width - 10,
                                     height: contentView.frame.size.height / 2 )
        NewsImageView.frame = CGRect(x: contentView.frame.minX + contentView.frame.size.width / 35,
                                     y: 5 ,
                                     width: contentView.frame.size.width - 20 ,
                                     height: contentView.frame.size.height / 1.5)
        
      
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        Newstitlelable.text = nil
        subtitlelable.text = nil
        NewsImageView.image = nil
    }

    func configure(with viewModel: NewsTableViewCellViewModel){
        
        
       
        Newstitlelable.text = viewModel.title
        subtitlelable.text = viewModel.subtitle
        
        if let data = viewModel.imageData{
            NewsImageView.image = UIImage(data: data)
        }
        else if let url = viewModel.imageUrl {
            URLSession.shared.dataTask(with: url) { [weak self] data, _ ,  error in
                guard let data = data, error == nil else {
                    return
                }
                viewModel.imageData = data
                DispatchQueue.main.async {
                    self?.NewsImageView.image = UIImage(data: data)
                }
 
            }.resume()
        }
    }
}
