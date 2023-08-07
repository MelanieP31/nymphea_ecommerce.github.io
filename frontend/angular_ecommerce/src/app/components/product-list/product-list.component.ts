import { Component, OnInit } from '@angular/core';
import { ProductService } from 'src/app/services/product.service';
import { Product } from 'src/app/common/product';
import { ActivatedRoute } from '@angular/router';

@Component({
  selector: 'app-product-list',
  templateUrl: './product-list.component.html',
  styleUrls: ['./product-list.component.css']
})
export class ProductListComponent implements OnInit {

  products: Product[] = [];
  currentCategoryId: number = 1;
  currentCategoryName: string = "";
  searchMode : boolean = false;

  //Afficher la pagination 
  thePageNumber : number = 1;
  thePageSize : number = 10;
  theTotalElements : number = 0; 

  constructor(private productService: ProductService,
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
  
  //Recherche par mot clé (recup mot clé - envoyé a la méthode dans service pour mapper les produits)
  handleSearchProducts(){
    const theKeyword : string = this.route.snapshot.paramMap.get('keyword')!;
    this.productService.searchProducts(theKeyword).subscribe(
      data => {
        this.products = data;
      }
    )
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
      this.currentCategoryName = 'Books';
    }

    // afficher la liste de produits (appeler la methode Productlist de Service et recup les "data" de cette méthode)
    this.productService.getProductList(this.currentCategoryId).subscribe(
      data => {
        this.products = data;
      }
    )

    //ajouter a cette liste de produits une pagination (recup donnee du ProductService et les assigné en fonction du JSON)
    this.productService.getProductListPaginate(this.thePageNumber-1, this.thePageSize, this.currentCategoryId).subscribe(
      data => {
        this.products = data._embedded.products;
        this.thePageNumber = data.page.number +1;
        this.thePageSize = data.page.size;
        this.theTotalElements = data.page.totalElements;
      }
    );



  }



}