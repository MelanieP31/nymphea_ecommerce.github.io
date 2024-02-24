package com.siteweb.ecommerce.service;

import java.util.Set;
import java.util.UUID;

import org.springframework.stereotype.Service;

import com.siteweb.ecommerce.dao.CustomerRepository;
import com.siteweb.ecommerce.dto.Purchase;
import com.siteweb.ecommerce.dto.PurchaseResponse;
import com.siteweb.ecommerce.entity.Customer;
import com.siteweb.ecommerce.entity.Order;
import com.siteweb.ecommerce.entity.OrderItem;

import jakarta.transaction.Transactional;

//anotation service
@Service

//implements checkoutservice : doit réécrire placeOrder.
public class CheckoutServiceImpl implements CheckoutService {

    //Client a la commande, qui contient la liste des item : référentiel 
	private CustomerRepository customerRepository;
	
	//Constructor pour injecter le customerRepository
    public CheckoutServiceImpl(CustomerRepository customerRepository) {
        this.customerRepository = customerRepository;
    }
    
    //ecrire la méthode placeOrder (recupérer du frontend le dto Purchase et envoyer le tracking number)
    //1- on recup de purchase : order, orderItems, adresse et client.
    //2- on dispach dans entité order (relation : il seront tous dispatcher)
    //3-On sauvegarde dans bdd le client complet (by repositoryCustomer)
    //4-on cré et on renvoie un numero de tracing unique

    @Override
    @Transactional
    public PurchaseResponse placeOrder(Purchase purchase) {

        // recupérer the order info from dto
        Order order = purchase.getOrder();

        // generate tracking number
        String orderTrackingNumber = generateOrderTrackingNumber(); //Méthode a écrire dessous
        order.setOrderTrackingNumber(orderTrackingNumber); //Le mettre dans order

        // populate order with orderItems
        Set<OrderItem> orderItems = purchase.getOrderItems(); //les recup from dto
        orderItems.forEach(item -> order.add(item)); //loop over chacun des order items et l'ajouter a order

        // populate order with billingAddress and shippingAddress
        order.setBillingAddress(purchase.getBillingAddress());
        order.setShippingAddress(purchase.getShippingAddress());

        // populate customer with order
        Customer customer = purchase.getCustomer();
        
        String theEmail = customer.getEmail();
        Customer customerFromDB = customerRepository.findByEmail(theEmail);
        if(customerFromDB != null) {
        	customer = customerFromDB;
        }
        customer.add(order);

        // save to the database
        customerRepository.save(customer);

        // return a response
        return new PurchaseResponse(orderTrackingNumber);
    }

    private String generateOrderTrackingNumber() {

        // generate a random UUID number (UUID version-4)
        // For details see: https://en.wikipedia.org/wiki/Universally_unique_identifier
        //
        return UUID.randomUUID().toString();
    }
}

