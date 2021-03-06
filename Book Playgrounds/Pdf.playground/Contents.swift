
import UIKit
import PDFKit
import PlaygroundSupport



class ProfileViewController: UIViewController {
    
    public var name: String?
    public var backgroundColor: UIColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    public var resource : String?
    
    override func loadView() {
        super.loadView()
        self.view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        // declaração de variaveis do tipo pdf 
        if #available(iOSApplicationExtension 11.0, *){
            
            var pdfdocument: PDFDocument?
            var pdfview: PDFView!
            
            pdfview = PDFView(frame: CGRect(x: 0, y: 0, width: 450, height: 600))
            
            let url = Bundle.main.url(forResource: resource, withExtension: "pdf")
            pdfdocument = PDFDocument(url: url!)
            
            
                // "pdf display mode single page continous" para a visualização ficar uma página  completa na view e não diminuir  o arquivo para todas as páginas ficarem visiveis na mesma view
            pdfview.document = pdfdocument
            pdfview.displayMode = PDFDisplayMode.singlePageContinuous
            pdfview.autoScales = true
            
            
            view.addSubview(pdfview)
            
        }
        else {
            print("PDFKit is not supported for versions before iOS 11.0")
        }

        
        
    }
}

class MyCollectionViewCell: UICollectionViewCell {
    
    // lave, e image view da celula
    
    public let nameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = NSTextAlignment.justified
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = UIFont.systemFont(ofSize: 6)
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(nameLabel)
        
        let imageView = UIImageView(image: #imageLiteral(resourceName: "IMG_0031.PNG"))
        self.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo:self.centerYAnchor).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 30).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        
        nameLabel.centerXAnchor.constraint(equalTo: imageView.centerXAnchor).isActive = true
        nameLabel.centerYAnchor.constraint(equalTo: imageView.centerYAnchor, constant:30).isActive = true
        
        nameLabel.widthAnchor.constraint(equalToConstant: 10)
        nameLabel.heightAnchor.constraint(equalToConstant: 30)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class CollectionViewController : UICollectionViewController {
    
    // CollectionView DataSource... nomes dos arquivos q a variavel resource  assumirá  , relativo a um nome de arquivo com extensão pdf
    private let nameList: [String] = ["Trabalho Escolar", "Trabalho Acadêmico", "Carta Moderna"]
    
    
    
    override func loadView() {
        super.loadView()
        self.collectionView?.backgroundColor = .white
        self.collectionView?.register(MyCollectionViewCell.self, forCellWithReuseIdentifier: "PlayCell")
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return nameList.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PlayCell", for: indexPath) as! MyCollectionViewCell
        
        // UIControlerViewCells bt not have viewDidLoad method, so we have to set the value directly into the element (nameLabel in this case). It is not usual.
        cell.nameLabel.text = nameList[indexPath.row]
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let profileCell = collectionView.cellForItem(at: indexPath) as! MyCollectionViewCell
        let profileViewController = ProfileViewController()
        
        profileViewController.name = profileCell.nameLabel.text
        profileViewController.resource = nameList[indexPath.row]
        navigationController?.pushViewController(profileViewController, animated: true)
    }
     
     
    
}

PlaygroundPage.current.liveView = UINavigationController(rootViewController:CollectionViewController(collectionViewLayout: UICollectionViewFlowLayout()))


