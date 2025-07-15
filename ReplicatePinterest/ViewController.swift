//
//  ViewController.swift
//  ReplicatePinterest
//
//  Created by The Coding Kid on 19/11/2024.
//

import UIKit

private let reuseIdentifier = "Cell"

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var collectionView : UICollectionView!
    //    var leftColumn: [MockModel] = []
    //    var rightColumn: [MockModel] = []
    var total = [MockModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        collectionView.collectionViewLayout = layout
        collectionView.dataSource = self
        collectionView.delegate = self
        let nib = UINib(nibName: "ImageCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: ImageCollectionViewCell.identifier)
        retrieveInformation()
        
    }
    
    private func sortElements(elements: [MockModel]) -> [MockModel] {
        var leftModel = [MockModel]()
        var rightModel = [MockModel]()
        
        var leftHeight: CGFloat = 0
        var rightHeight: CGFloat = 0
        
        for element in elements {
            let height = CGFloat(element.height ?? 200)
            
            if leftHeight <= rightHeight {
                leftModel.append(element)
                leftHeight += height
            } else {
                rightModel.append(element)
                rightHeight += height
            }
        }
        var combined = leftModel
        combined.append(contentsOf: rightModel)
        print("combined array", combined.reversed())
        return combined.reversed()
    }
    
    private func retrieveInformation() {
        do {
            let elements = try JSONDecoder().decode([MockModel].self, from: json!)
            total = sortElements(elements: elements)
            //            leftColumn = sortedElements.leftElement
            //            rightColumn = sortedElements.rightElement
            collectionView.reloadData()
        } catch {
            print("Error al decodificar JSON: \(error)")
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return total.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCollectionViewCell.identifier, for: indexPath) as! ImageCollectionViewCell 
        
        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor.darkGray.cgColor
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let element =  total[indexPath.item]
        if let height = element.height {
            print("Altura de la celda seleccionada: \(height)")
        } else {
            print("Altura de la celda seleccionada: No disponible")
        }
    }
    
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat = 10
        let availableWidth = collectionView.frame.width - padding
        let width = availableWidth / 2
        
        
        let element = total[indexPath.item]
        let height = CGFloat(element.height ?? 200)
        
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 40
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}

