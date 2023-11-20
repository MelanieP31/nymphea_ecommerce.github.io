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

@Service
public class CheckoutServiceImpl implements CheckoutService{
	
	private CustomerRepository customerRepository;
	
	public CheckoutServiceImpl(CustomerRepository customerRepository) {
		this.customerRepository = customerRepository;
	}

	@Override
	@Transactional
	public PurchaseResponse placeOrder(Purchase purchase) {
		// recuperer les infos de l'objet de transfert (Purchase)
		Order order = purchase.getOrder();
		
		//générer un numero de suivi de la commande (orderTrackingNumber)
		String orderTrackingNumber = generateOrderTrackingNumber();
		order.setOderTrackingNumber(orderTrackingNumber);		
		
		//Rentrer tout les articles orderItems dans Order
		Set<OrderItem> orderItems = purchase.getOrderItems();
		orderItems.forEach(item -> order.add(item));			
		
		//Associer Order avec adresse
		order.setBillingAdress(purchase.getBillingAdress());
		order.setShippingAdress(purchase.getShippingAdress());
				
		//Associer le client (cible reposotory) avec Order
		Customer customer = purchase.getCustomer();
		customer.add(order);		
		
		//Sauvegarder dans la bdd
		customerRepository.save(customer);
		
		//Envoyer une reponse
		return new PurchaseResponse(orderTrackingNumber);
		
	}

	private String generateOrderTrackingNumber() {
		return UUID.randomUUID().toString();
	}

}
