package com.siteweb.ecommerce.service;

import com.siteweb.ecommerce.dto.Purchase;
import com.siteweb.ecommerce.dto.PurchaseResponse;

public interface CheckoutService {
	
	PurchaseResponse placeOrder(Purchase purchase);
	

}
