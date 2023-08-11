import { Component, OnInit } from '@angular/core';
import { CartItem } from 'src/app/common/cart-item';
import { CartService } from 'src/app/services/cart.service';

@Component({
  selector: 'app-cart-details',
  templateUrl: './cart-details.component.html',
  styleUrls: ['./cart-details.component.css']
})
export class CartDetailsComponent implements OnInit {

  cartItems : CartItem[] = [];
  totalPrice : number =0;
  totalQuantity : number =0;

  constructor(private cartService : CartService) { }

  ngOnInit(): void {
    this.listCartDetails();
  }

  //Recuperer les articles, subscribe total price et quantoty 
  listCartDetails() {
    this.cartItems = this.cartService.cartItems;
    this.cartService.totalPrice.subscribe(
      data => this.totalPrice = data
    );

    this.cartService.totalQuantity.subscribe(
      data => this.totalQuantity = data
    );

    this.cartService.computeCartTotals();
  }

  //incrementer la quantoty directment dans le panier
  incrementQuantity(theCartItem: CartItem){
    this.cartService.addToCart(theCartItem);
  }

  //decrementer la quantité dans le panier
  decrementQuantity(theCartItem: CartItem){
    this.cartService.decrementQuantity(theCartItem);
  }

  remove(theCartItem:CartItem){
    this.cartService.remove(theCartItem);
  }

}
