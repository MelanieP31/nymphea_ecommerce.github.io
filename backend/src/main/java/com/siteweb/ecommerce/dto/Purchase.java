package com.siteweb.ecommerce.dto;

import java.util.Set;

import com.siteweb.ecommerce.entity.Address;
import com.siteweb.ecommerce.entity.Customer;
import com.siteweb.ecommerce.entity.Order;
import com.siteweb.ecommerce.entity.OrderItem;

import lombok.Data;


//dataTransferObject = la classe qui contient le client, l'adresse, le tableau des produits commander
//Tout ce qu'o recup en frontend et qu'on dispachera dans les entités en backend et finalemet dans bdd

//Getter et Setter @Data de Lombok
@Data
public class Purchase {

    private Customer customer;
    private Address shippingAddress;
    private Address billingAddress;
    private Order order;
    private Set<OrderItem> orderItems; // Dans JsON se sera juste une collection d'item et dans frontend un tableau array[] pas de soucis de transfert entre ces 2.

}
