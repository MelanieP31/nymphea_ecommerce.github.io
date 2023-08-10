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

}
