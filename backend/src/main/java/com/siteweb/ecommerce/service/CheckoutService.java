package com.siteweb.ecommerce.service;

import com.siteweb.ecommerce.dto.Purchase;
import com.siteweb.ecommerce.dto.PurchaseResponse;


//Definir une méthode pour pouvoir utiliser notre dto l'objet : Purchase - et envoyer le trackingnumber
//Interface a implementer : juste la rep ici, implementation: decrit la méthode.
public interface CheckoutService {

    PurchaseResponse placeOrder(Purchase purchase);
}
