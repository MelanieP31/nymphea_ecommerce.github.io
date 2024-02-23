import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Product } from '../common/product';
import { Observable } from 'rxjs';
import { map } from 'rxjs/operators';
import { ProductCategory } from '../common/product-category';

//Recupere les donnes de l'API on observable dans des tableaux. "redistribuer"/assigner apres dans les composants necessaire.
@Injectable({
  providedIn: 'root'
})
export class ProductService {
 
  private baseUrl = 'http://localhost:8080/api/products';
  private categoryUrl = 'http://localhost:8080/api/product-category';

  constructor(private httpClient: HttpClient) { }

  // Retourne 1 produit par son Id (detail view du produit)
  getProduct(theProductId: number) : Observable<Product>  { 
    const productUrl = `${this.baseUrl}/${theProductId}`;
    return this.httpClient.get<Product>(productUrl);
  }

  //Rechercher un produit par sa catégorie (retourne liste de produit dans une catégorie)
  getProductList(theCategoryId: number): Observable<Product[]> {
    const searchUrl = `${this.baseUrl}/search/findByCategoryId?id=${theCategoryId}`;
    return this.getProducts(searchUrl);
  }

  //Recherche un produit par mot clé(retourne liste de produits searchbar)
  searchProducts(theKeyword: string) : Observable<Product[]>{
    const searchUrl =`${this.baseUrl}/search/findByNameContaining?name=${theKeyword}`;
    return this.getProducts(searchUrl);
  }

  //Méthode retourne une liste de produits
  private getProducts(searchUrl: string): Observable<Product[]> {
    return this.httpClient.get<GetResponseProducts>(searchUrl).pipe(
      map(response => response._embedded.products)
    );
  }

  //Retourne toutes les catégories (appler le endpoint de categorie de l'API - créer avec SB) les faire passer dans un pipe(map) pour qu'on puisse les lire ici (interface pour les transfo en tableau)
  getProductCategories(): Observable<ProductCategory[]> {
    return this.httpClient.get<GetResponseProductCategory>(this.categoryUrl).pipe(
      map(response => response._embedded.productCategory)
    );
  }

  //Prise en charge de la pagination dans une liste de produits
  getProductListPaginate(thePage: number, thePageSize : number, theCategoryId:number): Observable<GetResponseProducts> {
    const searchUrl = `${this.baseUrl}/search/findByCategoryId?id=${theCategoryId}`
                        +`&page=${thePage}&size=${thePageSize}`;
    return this.httpClient.get<GetResponseProducts>(searchUrl);
  }

  //La pagination suite a la recherche par mot clé !
  searchProductsPaginate(thePage: number, thePageSize : number, theKeyword:string): Observable<GetResponseProducts> {
    const searchUrl = `${this.baseUrl}/search/findByNameContaining`
                        +`?name=${theKeyword}&page=${thePage}&size=${thePageSize}`;
    return this.httpClient.get<GetResponseProducts>(searchUrl);
  }



}


//recup metadata

interface GetResponseProducts {
  _embedded: {
    products: Product[];
  },
  page : { 
    size : number,
    totalElements : number, 
    totaPages : number,
    number : number
  }
}

interface GetResponseProductCategory {
  _embedded: {
    productCategory: ProductCategory[];
  }
}