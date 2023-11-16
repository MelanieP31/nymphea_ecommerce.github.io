import { Component, OnInit } from '@angular/core';
import { Product } from 'src/app/common/product';
import { ActivatedRoute } from '@angular/router';
import { ProductService } from 'src/app/services/product.service';
import { CartItem } from 'src/app/common/cart-item';
import { CartService } from 'src/app/services/cart.service';

@Component({
  selector: 'app-product-details',
  templateUrl: './product-details.component.html',
  styleUrls: ['./product-details.component.css']
})
export class ProductDetailsComponent implements OnInit {

  product!: Product;
  showMe1:boolean = true;
  showMe2:boolean = false;
  showMe3: boolean = false;
  id! : string;

  constructor(private productService : ProductService,
              private route : ActivatedRoute,
              private cartService : CartService) { }

  ngOnInit(): void {
    this.route.paramMap.subscribe(()  => {
      this.handleProductDetails();
    })
  }


  handleProductDetails() {
    //get id param string convert to number + symbol
    const theProductId: number = +this.route.snapshot.paramMap.get('id')!;

    this.productService.getProduct(theProductId).subscribe(
      data => {
        this.product = data;
      }
    )
  }

  addToCart(){


    console.log(`name = ${this.product.name}, price = ${this.product.unitPrice}`);

    const theCartItem = new CartItem(this.product);

    this.cartService.addToCart(theCartItem);
  }

  toggleTag1(){
    this.showMe1=!this.showMe1;
    this.showMe2=false;
    this.showMe3=false;
  }

  toggleTag2(){
    this.showMe1=false;
    this.showMe2=!this.showMe2;
    this.showMe3=false;
  }
  toggleTag3(){
    this.showMe1=false;
    this.showMe2=false;
    this.showMe3=!this.showMe3;
  }

}
