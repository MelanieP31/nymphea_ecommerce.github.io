import { Product } from "./product";

export class CartItem {

    id: string;
    name : string;
    subname:string;
    introduction : string;
    imageUrl : string;
    unitPrice : number;

    quantity : number;

    constructor(product : Product){ 
        this.id = product.id;
        this.name = product.name;
        this.imageUrl = product.imageUrl;
        this.unitPrice = product.unitPrice;
        this.subname = product.subname;
        this.introduction=product.introduction;

        this.quantity = 1;
    }
}
