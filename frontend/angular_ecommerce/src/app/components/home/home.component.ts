import { Component, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { ProductService } from 'src/app/services/product.service';
import { Product } from 'src/app/common/product';



@Component({
  selector: 'app-home',
  templateUrl: './home.component.html',
  styleUrls: ['./home.component.css']
})
export class HomeComponent implements OnInit {



  constructor(private productService: ProductService,) { }
  products: Product[] = []; 


  ngOnInit() { 
    this.listProducts();
  }

  listProducts() {
    this.productService.getProductList(1).subscribe(
      data => {
        this.products = data;
        
      }
    )
  }

  newsletterInscription(){
    alert(`En cours d'implémentation`);
  }

}
