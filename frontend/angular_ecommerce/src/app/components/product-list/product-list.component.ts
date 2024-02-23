import { Component, OnInit } from '@angular/core';
import { ProductService } from 'src/app/services/product.service';
import { Product } from 'src/app/common/product';
import { ActivatedRoute } from '@angular/router';
import { CartItem } from 'src/app/common/cart-item';
import { CartService } from 'src/app/services/cart.service';

@Component({
  selector: 'app-product-list',
  templateUrl: './product-list.component.html',
  styleUrls: ['./product-list.component.css']
})
export class ProductListComponent implements OnInit {

  products: Product[] = []; 
  searchMode : boolean = false;

  //Chercher par catégorie (et afficher nom de la categorie)
  currentCategoryId: number =1;
  currentCategoryName: string = "";
  //Reinitialisation page au changement de categorie
  previousCategoryId: number = 1;
  
  //Afficher la pagination 
  thePageNumber : number;
  thePageSize : number = 5;
  theTotalElements : number = 0; 

  //Pagination pour la recherche par mot clé
  previousKeyword : string ="";

  constructor(private productService: ProductService,
              private cartService : CartService,
              private route: ActivatedRoute) { }


  //Lancer la liste de produits 
  ngOnInit() {
    this.route.paramMap.subscribe(() => {
      this.listProducts();
    });
  }

  //Si mot clé est tapé lancer la recherche sinon afficher une liste
  listProducts(){
    this.searchMode = this.route.snapshot.paramMap.has('keyword');
    if(this.searchMode){
      this.handleSearchProducts();
    } else{
      this.handleListProducts();
    }
  }
  
  //Recherche par mot clé (recup mot clé - recup la méthode dans service pour mapper les produits)
  handleSearchProducts(){
    const theKeyword : string = this.route.snapshot.paramMap.get('keyword')!;

    //remettre la page a 1 si nouveaux mot-clé
    if(this.previousKeyword != theKeyword){
      this.thePageNumber =1;
    }

    this.previousKeyword = theKeyword;
    console.log(`keyword=${theKeyword}, the PageNumber=${this.thePageNumber}`);

//Méthode du productservice : ramene un tableau des produits 
    this.productService.searchProductsPaginate(this.thePageNumber -1,
                                            this.thePageSize,
                                            theKeyword).subscribe(this.processResult());
  }

  //afficher la liste produits en fonction id ou nom de catégorie
  handleListProducts(){
    // check if "id" parameter is available
    const hasCategoryId: boolean = this.route.snapshot.paramMap.has('id');
    
    if (hasCategoryId) {
      // get the "id" param string. convert string to a number using the "+" symbol
      this.currentCategoryId = +this.route.snapshot.paramMap.get('id')!;
      // get the "name" param string
      this.currentCategoryName = this.route.snapshot.paramMap.get('name')!;
    }
    else {
      // not category id available ... default to category id 1
      this.currentCategoryId = 1;
      this.currentCategoryName = "Savon";
    }

    //Changement de catégorie : réinitialisement des pages à 1.
    if(this.previousCategoryId != this.currentCategoryId){
      this.thePageNumber =1;
    }

    //Keeping track of category for debug purpose
    this.previousCategoryId = this.currentCategoryId;
    console.log(`currentCategoryId = ${this.currentCategoryId}, thePageNumber=${this.thePageNumber} `);

    //afficher la liste des produits et l'afficher avec une pagination (recup donnee du ProductService et les assigné en fonction du JSON (param cette class = param JSON))
    //param thePageNumber-1 : Spring basé sur 0, alors que angular 1 (donc faut faire -1)
    this.productService.getProductListPaginate(this.thePageNumber -1, 
                                              this.thePageSize, 
                                              this.currentCategoryId).subscribe(this.processResult());
  }

  //Dropdown menu pour que l'utilisateur puisse choir le nombre d'item par page
  updatePageSize(pageSize:string){
    this.thePageSize = +pageSize;
    this.thePageNumber =1;
    this.listProducts();

  }

  //gauche : propriété assigner sur la page , droite : ce qui revient du JSON
  processResult(){
    return(data:any) => {
      this.products = data._embedded.products;
      this.thePageNumber = data.page.number + 1;
      this.thePageSize = data.page.size;
      this.theTotalElements = data.page.totalElements;
    };
  }

  //Ajouter les produits au paniers
  addToCart(theProduct : Product){
    console.log(`Adding to cart : ${theProduct.name}, ${theProduct.unitPrice} `);

    const theCartItem = new CartItem(theProduct);

    this.cartService.addToCart(theCartItem);

  }



}