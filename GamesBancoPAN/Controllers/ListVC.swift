//
//  ListVC.swift
//  GamesBancoPAN
//
//  Created by Paulo Lourenço on 23/01/18.
//

import UIKit
import CollectionViewGridLayout
import UIScrollView_InfiniteScroll

class ListVC: UIViewController {
    
    //outlets
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var refreshBtn: UIBarButtonItem!
    //vars
    let gamesViewModel = GamesViewModel()
    var refreshControl: UIRefreshControl? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
        setupInfiniteScroll()
        setupPullRefresh()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
                
        //Avoid list update when it returns from the details screen
        if gamesViewModel.topGames.count == 0 {
            fetchTopGames(next: false)
        }
    }
    
    func fetchTopGames(next: Bool) {
        
        let offset = next ? gamesViewModel.topGames.count : 0
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        if Utils.isConnected() {
            self.refreshBtn.isEnabled = false
            gamesViewModel.getTop(offset: offset, completed: { (isOk) in
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                if isOk {
                    self.collectionView.reloadData()
                    self.collectionView.finishInfiniteScroll()
                    self.refreshControl?.endRefreshing()
                } else {
                    self.refreshBtn.isEnabled = true
                    self.showAlert(title: "Erro", message: "Ocorreu um erro. Verifique sua conexão e tente novamente.")
                }
            })
        } else {
            gamesViewModel.getTopSaved(offset: offset, completed: { (isOk) in
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                if isOk {
                    if offset == 0, !(self.refreshControl?.isRefreshing)! {
                        self.showAlert(title: "Alerta", message: "Você está sem internet. Serão exibidos apenas os dados obtidos na última vez em que o app foi utilizado.")
                    }
                    self.collectionView.reloadData()
                    self.collectionView.finishInfiniteScroll()
                    self.refreshControl?.endRefreshing()
                    
                } else {
                    self.showAlert(title: "Sem conexão com a internet", message: "Não foi possível conectar ao servidor do Twitch e não há dados salvos a serem exibidos.")
                    self.refreshBtn.isEnabled = true
                }
            })
        }
    }
    
    func setupPullRefresh() {
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(refreshAction), for: UIControlEvents.valueChanged)
        collectionView.addSubview(refreshControl!)
    }
    
    @IBAction func refreshAction() {
        fetchTopGames(next: false)
    }
    
    func setupCollectionView() {
        let layout =  CollectionViewVerticalGridLayout()
        
        collectionView.collectionViewLayout = layout
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func setupInfiniteScroll() {
        collectionView.infiniteScrollIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        
        collectionView.setShouldShowInfiniteScrollHandler { (tableView) -> Bool in
            if Utils.isConnected() {
                return (self.gamesViewModel.topGames.count < 100)
            } else {
                return (self.gamesViewModel.topGames.count < self.gamesViewModel.allSavedGames.count)
            }
        }
        
        collectionView.addInfiniteScroll { (tableView) in
            print("Loading more!!!")
            self.fetchTopGames(next: true)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailsSegue" {
            let detailsVC = segue.destination as! DetailsVC
            detailsVC.game = (sender as! GameModel)
        }
    }
    
}

extension ListVC: CollectionViewDelegateVerticalGridLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, rowSpacingForSection section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, columnSpacingForSection section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSection section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 16, bottom: 10, right: 16)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        heightForItemAt indexPath: IndexPath, columnWidth: CGFloat) -> CGFloat {
        return 189
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, numberOfColumnsForSection section: Int) -> Int {
        return 2 //(UIDevice().userInterfaceIdiom == .pad ? 3 : 2)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gamesViewModel.topGames.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard gamesViewModel.topGames.count-1 >= indexPath.row else {
            print("Incorrect index")
            return UICollectionViewCell()
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GameCell", for: indexPath) as! GameCell
        cell.configureCell(game: gamesViewModel.topGames[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard gamesViewModel.topGames.count-1 >= indexPath.row else {
            print("Incorrect index")
            return
        }
        
        performSegue(withIdentifier: "detailsSegue", sender: gamesViewModel.topGames[indexPath.row])
    }
    
}








