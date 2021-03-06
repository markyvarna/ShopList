//
//  ItemListTableVC.swift
//  ShopList
//
//  Created by Markus Varner on 8/31/18.
//  Copyright © 2018 Markus Varner. All rights reserved.
//

import UIKit
import CoreData

class ItemListTableVC: UITableViewController, NSFetchedResultsControllerDelegate, ItemTableViewCellDelegate {
    
    //MARK: - Delagate Method
    
    func didBuyToggled(cell: ItemTableViewCell) {
        
        guard let index = tableView.indexPath(for: cell) else {return}
        guard let item = fetchResultsController.fetchedObjects?[index.row] else {return}
        item.didBuy = !item.didBuy
        CoreDataStack.saveToPersistentStore()
       
    }
    
    //MARK: - Properties -  NSFetchedResultsController
    
    let fetchResultsController: NSFetchedResultsController<Item> = {
        
        //init fetch request - use sort descriptor - return
        let fetchRequest: NSFetchRequest<Item> = Item.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        return NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: CoreDataStack.context, sectionNameKeyPath: nil, cacheName: nil)
        
    }()
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        //if something gets deleted from the tableView, this will execute
        
        switch type{
            
        case .delete:
            guard let indexPath = indexPath else {return}
            tableView.deleteRows(at: [indexPath], with: .automatic)
        case .insert:
            guard let newIndexPath = newIndexPath else {return}
            tableView.insertRows(at: [newIndexPath], with: .automatic)
        case .move:
            guard let indexPath = indexPath,
                let newIndexPath = newIndexPath else {return}
            tableView.moveRow(at: indexPath, to: newIndexPath)
        case .update:
            guard let indexPath = indexPath else {return}
            tableView.reloadRows(at: [indexPath], with: .automatic)
            
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchResultsController.delegate = self
        try? fetchResultsController.performFetch()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
        
    }
    
    // MARK: - Table View Data Source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return fetchResultsController.fetchedObjects?.count ?? 0
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //cast cell as a ItemTableViewCell
        let cell = tableView.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath) as? ItemTableViewCell
        
        let item = fetchResultsController.fetchedObjects?[indexPath.row]
        cell?.nameLabel.text = item?.name
        cell?.item = item
        cell?.delegate = self
        
        return cell ?? UITableViewCell()
        
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            guard let item = fetchResultsController.fetchedObjects?[indexPath.row] else {return}
            CoreDataStack.delete(item: item)
        }
        
    }
    
    //MARK: - UIAlertController
    
    func presentAlertController() {
        
        let alertController = UIAlertController(title: "Add a Movie", message: "Marvel Movies Only...", preferredStyle: .alert)
        
        alertController.addTextField { (itemTextField) in
            itemTextField.placeholder = "Movie Name"
            
        }
        
        let dismissAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let saveAction = UIAlertAction(title: "Accept", style: .default) { ( _ )  in
            guard let itemName = alertController.textFields?[0].text else {return}
            Item(name: itemName)
            CoreDataStack.saveToPersistentStore()
            self.tableView.reloadData()
            
        }
        
        alertController.addAction(dismissAction)
        alertController.addAction(saveAction)
        present(alertController, animated:  true)
        
    }
    
    //MARK: - IBActions
    @IBAction func addItemButtonTapped(_ sender: UIBarButtonItem) {
        
        presentAlertController()
        
    }
    
    //MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToDetail" {
            let destinationvc = segue.destination as? DetailViewController
            guard let indexPath = tableView.indexPathForSelectedRow?.row else {return}
            guard let item =  fetchResultsController.fetchedObjects?[indexPath] else {return}
            destinationvc?.itemName = item.name
        }
    }
}





