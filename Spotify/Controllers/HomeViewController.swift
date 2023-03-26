//
//  ViewController.swift
//  Spotify
//
//  Created by Javlonbek Sharipov on 20/03/23.
//

import UIKit

class HomeViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gear"), style: .done, target: self, action: #selector(didTapSettings))
        fetchData()
    }
    
    private func fetchData() {
        ApiCaller.shared.getRecommendedGenres { result in
            switch result {
            case .success(let recommendedGenres):
                let genres = recommendedGenres.genres
                var seeds = Set<String>()
                while seeds.count < 5 {
                    if let random = genres.randomElement() {
                        seeds.insert(random)
                    }
                }
                
                ApiCaller.shared.getRecommendations(seed: seeds) { result in
                    print(result)
                }
                break
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    @objc func didTapSettings() {
        let vc = SettingsViewController()
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
}

