import { Injectable } from '@angular/core';
import { CartItem } from '../common/cart-item';
import { BehaviorSubject, Subject } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class CartService {

  cartItems: CartItem[] = [];
  //Reference web browser session storage
  //storage: Storage = sessionStorage;
  storage: Storage = localStorage;

  totalPrice: Subject<number> = new BehaviorSubject<number>(0);
  totalQuantity: Subject<number> = new BehaviorSubject<number>(0);

  constructor() {
    //lire les donnees du storage - key = cartItems
    //JSON.parse : lie la chaine et la convertie en un objet
    let data = JSON.parse(this.storage.getItem('cartItems')!);
    //verifier qu'il y a bien des donnes + total : ajouter les data du storage
    if (data != null) {
      this.cartItems = data;
      this.computeCartTotals();
    }
  }

  //ajouter des items dans le panier
  addToCart(theCartItem: CartItem) {
    // 1 : Regarder si on a deja des items dans le panier
    let alreadyExistsInCart: boolean = false;
    let existingCartItem: CartItem = undefined!;

    if (this.cartItems.length > 0) {
      // 1-1 : On les retrouve en comprant les ID
      existingCartItem = this.cartItems.find(tempCartItem => tempCartItem.id === theCartItem.id)!;
      alreadyExistsInCart = (existingCartItem != undefined);
    }
    //si il existe deja un item alors on augmente sa quantité
    if (alreadyExistsInCart) {
      existingCartItem.quantity++;
    }
    else {
      // sinon on l'ajoute dans notre tableau d'items
      this.cartItems.push(theCartItem);
    }

    // on apelle un méthode qui calcul le total de quantité et le prix
    this.computeCartTotals();
  }

  //Diminuer la quantité des items dans le panier (simple decrementation) si 0 = remove
  decrementQuantity(theCartItem:CartItem){
    theCartItem.quantity--;

    if(theCartItem.quantity === 0){
      this.remove(theCartItem);
    }else{
      this.computeCartTotals();
    }
  }

    //Trouver ou il se trouve dans l'array (index)
  remove(theCartItem: CartItem) {
    const itemIndex = this.cartItems.findIndex(tempCartItem => tempCartItem.id == theCartItem.id);
    //si trouvé (en pos 0 à x, donc sup -1) alors le suppr
    if(itemIndex >-1){
      this.cartItems.splice(itemIndex, 1);

      this.computeCartTotals();
    }
  }

  //Méthode math calcul prix et quantité total
  computeCartTotals() {

    let totalPriceValue: number = 0;
    let totalQuantityValue: number = 0;

    for (let currentCartItem of this.cartItems) {
      totalPriceValue += currentCartItem.quantity * currentCartItem.unitPrice;
      totalQuantityValue += currentCartItem.quantity;
    }

    // On met a dispo ces data si on veut les recup : subscribe
    this.totalPrice.next(totalPriceValue);
    this.totalQuantity.next(totalQuantityValue);

    // log cart data just for debugging purposes
    this.logCartData(totalPriceValue, totalQuantityValue);

    //persistance des donne storage
    this.persistCartItems();
  }

  //ajouter methode persisteCartItems() key : cartItems ; value = objet du cartItems convertie (JSON.stringify) en chaine de caractere
  persistCartItems() {
    this.storage.setItem('cartItems', JSON.stringify(this.cartItems));
  }
  

  logCartData(totalPriceValue: number, totalQuantityValue: number) {

    console.log('Contents of the cart');
    for (let tempCartItem of this.cartItems) {
      const subTotalPrice = tempCartItem.quantity * tempCartItem.unitPrice;
      console.log(`name: ${tempCartItem.name}, quantity=${tempCartItem.quantity}, unitPrice=${tempCartItem.unitPrice}, subTotalPrice=${subTotalPrice}, introduction=${tempCartItem.introduction}`);
    }

    console.log(`totalPrice: ${totalPriceValue.toFixed(2)}, totalQuantity: ${totalQuantityValue}`);
    console.log('----');
  }
}
